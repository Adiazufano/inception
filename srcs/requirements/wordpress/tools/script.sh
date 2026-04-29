#!/bin/ash

SQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

set -e

echo "Esperando a MariaDB..."
while ! nc -z mariadb 3306; do
    sleep 2
done
echo "MariaDB lista."

cd /var/www/wordpress

if [ ! -f "wp-config.php" ]; then
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	cp -rf wordpress/* .
	rm -rf wordpress latest.tar.gz

	cp wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/$SQL_DATABASE/g" wp-config.php
	sed -i "s/username_here/$SQL_USER/g" wp-config.php
	sed -i "s/password_here/$SQL_PASSWORD/g" wp-config.php
	sed -i "s/define( 'DB_HOST', 'localhost' )/define( 'DB_HOST', 'mariadb:3306' )/g" wp-config.php

	wp core install \
        --url="https://aldiaz-u.42.fr" \
        --title="aldiaz-u WordPress" \
        --admin_user="aldiaz-u" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="aldiaz-u@student.42madrid.com" \
        --allow-root
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo 'ejecutando wordpress ...'

exec /usr/sbin/php-fpm82 -F

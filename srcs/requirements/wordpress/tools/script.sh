#!/bin/ash

SQL_PASSWORD=$(cat /run/secrets/db_password)

set -e

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	cp -rf wordpress/* .
	rm -rf wordpress latest.tar.gz

	cp wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/$SQL_DATABASE/g" wp-config.php
	sed -i "s/username_here/$SQL_USER/g" wp-config.php
	sed -i "s/password_here/$SQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/mariadb/g" wp-config.php
fi

exec /usr/sbin/php-fpm82 -F

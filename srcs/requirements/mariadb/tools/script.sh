#!/bin/ash

set -e
SQL_PASSWORD=$(cat /run/secrets/db_password)



if [ ! -f "$MARIADB_DATA_DIR/ibdata1" ]; then
		mariadb-install-db\
			--user=$MARIADB_USER\
			--datadir=$MARIADB_DATA_DIR

		mariadbd &
		while ! mariadb -e "SELECT 1" 2>/dev/null; do
			sleep 1
		done
		mariadb -e "CREATE DATABASE $SQL_DATABASE;"
		mariadb -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';"
		mariadb -e "GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO '$SQL_USER'@'%';"
		mariadb -e "FLUSH PRIVILEGES;"
		mariadb-admin shutdown
fi

exec mariadbd

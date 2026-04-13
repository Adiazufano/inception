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
		mariadb -e "CREATE DATABASE $SQL_DATABASE"
		mariadb -e "CREATE USER '$SQL_USER'@localhost IDENTIFIED BY '$SQL_PASSWORDx'"
		mariadb -e "GRANT ALL PRIVILEGES ON inception.* TO '$SQL_USER'@'localhost'"
		mariadb -e "FLUSH PRIVILEGES"
		mariadb-admin shutdown
fi

exec mariadbd
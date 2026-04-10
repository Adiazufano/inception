#!/bin/ash

set -e


if [ ! -f "$MARIADB_DATA_DIR/ibdata1" ]; then
		mariadb-install-db\
			--user=$MARIADB_USER\
			--datadir=$MARIADB_DATA_DIR
fi

exec mariadbd
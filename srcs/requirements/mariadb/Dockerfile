FROM alpine:3.22

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql && \
	chown -R  mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf
COPY ./tools/script.sh /usr/local/bin/script.sh

RUN chmod -x /usr/local/bin/script.sh

EXPOSE 3306

CMD ["sh", "/usr/local/bin/script.sh"]
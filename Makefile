up:
	mkdir -p /home/aldiaz-u/data/db
	mkdir -p /home/aldiaz-u/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

mariadbLogs:
	docker logs mariadb

wordpressLogs:
	docker logs wordpress

nginxLogs:
	docker logs nginx

ps:
	docker ps

downV:
	docker compose -f srcs/docker-compose.yml down -v
# Variables
NAME        = inception
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH   = /home/aldiaz-u/data

# Colores para mensajes (opcional, pero queda muy pro en 42)
GREEN       = \033[0;32m
RED         = \033[0;31m
RESET       = \033[0m

# Regla por defecto (la que se ejecuta al escribir 'make')
all: up

# 1. Preparación y Lanzamiento (Build and Launch)
up:
	@echo "$(GREEN)Creating data directories...$(RESET)"
	@mkdir -p $(DATA_PATH)/db
	@mkdir -p $(DATA_PATH)/wordpress
	@echo "$(GREEN)Building and starting containers...$(RESET)"
	docker compose -f $(COMPOSE_FILE) up --build -d

# 2. Parada (Stop)
down:
	@echo "$(RED)Stopping containers...$(RESET)"
	docker compose -f $(COMPOSE_FILE) down

# 3. Limpieza de imágenes y contenedores (Clean)
clean: down
	@echo "$(RED)Removing images...$(RESET)"
	docker system prune -a -f

# 4. Limpieza Profunda (fclean de la DEV_DOC)
fclean: clean
	@echo "$(RED)Removing persistent volumes and data...$(RESET)"
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	sudo rm -rf $(DATA_PATH)
	@echo "$(GREEN)System is totally clean.$(RESET)"

re: fclean all

# 5. Comandos de Gestión y Debugging (Management)
ps:
	docker ps

mariadbLogs:
	docker logs mariadb

wordpressLogs:
	docker logs wordpress

nginxLogs:
	docker logs nginx

# Reglas especiales para evitar conflictos con archivos
.PHONY: all up down clean fclean re ps mariadbLogs wordpressLogs nginxLogs
# Colors
RESET=$(shell echo -e "\033[0m")
GREEN=$(shell echo -e "\033[1;32m")
BLUE=$(shell echo -e "\033[1;34m")
YELLOW=$(shell echo -e "\033[1;33m")
RED=$(shell echo -e "\033[1;31m")

#crete data directories
DATA_DIR=/home/mkhlouf/data

#create mariadb and wordpress data directories
MARIADB_DIR=$(DATA_DIR)/mariadb
WORDPRESS_DIR=$(DATA_DIR)/wordpress

# Docker Compose File
COMPOSE_FILE=srcs/docker-compose.yml

# Targets
all:
	@echo "$(YELLOW)==> Creating Data directory...$(RESET)"
	@mkdir -p $(DATA_DIR)
	@echo "$(YELLOW)==> Creating MariaDB data directory...$(RESET)"
	@mkdir -p $(MARIADB_DIR)
	@echo "$(YELLOW)==> Creating WordPress data directory...$(RESET)"
	@mkdir -p $(WORDPRESS_DIR)
	@echo "$(YELLOW)==> Building and starting containers...$(RESET)"
	@$(MAKE) images
	@$(MAKE) up
	@echo "$(GREEN)==> Done!$(RESET)"


#docer commands

#to build images
images:
	@echo "$(BLUE)==> Building Docker images...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) build

#to display logs
logs:
	@echo "$(BLUE)==> Displaying container logs...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) logs -f

#to start containers
up:
	@echo "$(BLUE)==> Starting containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) up -d


#to start containers
ps:
	@echo "$(BLUE)==> Displaying containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) ps


#to stop containers
down:
	@echo "$(RED)==> Stopping containers...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down


#to create mariadb data directory
clean:
	@echo "$(RED)==> Removing containers, images, and volumes...$(RESET)"
	@docker compose -f $(COMPOSE_FILE) down --rmi all -v

#to remove data directories
fclean: clean
	@echo "$(RED)==> Removing data directories...$(RESET)"
	@sudo rm -rf $(DATA_DIR)
	@docker system prune -f --volumes

re: fclean all

.PHONY: all clean fclean re up down images logs ps
COMPOSE = srcs/docker-compose.yml
DATA_PATH = $(HOME)/data
WP_PATH = $(DATA_PATH)/wordpress
DB_PATH = $(DATA_PATH)/mariadb
DOCKER = docker
DOCKER_COMPOSE = docker-compose -f $(COMPOSE)

GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
RESET = \033[0m

.PHONY: all up down re clean fclean prune status logs help

all: up

up:
	@echo "$(GREEN)Création des répertoires de données...$(RESET)"
	@mkdir -p $(WP_PATH)
	@mkdir -p $(DB_PATH)
	@echo "$(GREEN)Construction et démarrage des conteneurs...$(RESET)"
	$(DOCKER_COMPOSE) up --build -d
	@echo "$(GREEN)Conteneurs en cours d'exécution:$(RESET)"
	$(DOCKER) ps

down:
	@echo "$(YELLOW)Arrêt des conteneurs...$(RESET)"
	$(DOCKER_COMPOSE) down -v

clean:
	@echo "$(YELLOW)Nettoyage des conteneurs, réseaux et volumes non utilisés...$(RESET)"
	$(DOCKER) system prune -f

fclean: down
	@echo "$(RED)Suppression complète des données et ressources Docker...$(RESET)"
	$(DOCKER) system prune -af --volumes
	sudo rm -rf $(DATA_PATH)

prune:
	@echo "$(RED)Nettoyage forcé de toutes les ressources Docker...$(RESET)"
	$(DOCKER) system prune -af

re: fclean all

status:
	@echo "$(GREEN)Statut des conteneurs:$(RESET)"
	$(DOCKER) ps -a
	@echo "\n$(GREEN)Réseaux:$(RESET)"
	$(DOCKER) network ls
	@echo "\n$(GREEN)Volumes:$(RESET)"
	$(DOCKER) volume ls

logs:
	@echo "$(GREEN)Logs des conteneurs:$(RESET)"
	$(DOCKER_COMPOSE) logs

help:
	@echo "$(GREEN)Commandes disponibles:$(RESET)"
	@echo "  make up      : Démarre les conteneurs"
	@echo "  make down    : Arrête les conteneurs"
	@echo "  make clean   : Nettoie les ressources Docker non utilisées"
	@echo "  make fclean  : Nettoie complètement et supprime les données"
	@echo "  make re      : Reconstruit le projet de zéro"
	@echo "  make prune   : Supprime toutes les ressources Docker"
	@echo "  make status  : Affiche l'état des conteneurs, réseaux et volumes"
	@echo "  make logs    : Affiche les logs des conteneurs"
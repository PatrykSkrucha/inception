COMPOSE= -f srcs/docker-compose.yml

all: build

run:
	@mkdir -p /home/${USER}/data/wp_vol
	@mkdir -p /home/${USER}/data/db_vol
	@docker compose ${COMPOSE} up -d

build:
	@mkdir -p /home/${USER}/data/wp_vol
	@mkdir -p /home/${USER}/data/db_vol
	@docker compose ${COMPOSE} build --no-cache --pull

build_run: build run

down:
	@docker compose ${COMPOSE} down

up:
	@docker compose ${COMPOSE} up -d

clean:
	@docker compose ${COMPOSE} down --volumes --rmi all --remove-orphans

fclean: clean
	@docker system prune --all
	@docker builder prune --all
	@sudo rm -rf /home/${USER}/data

re: fclean run

.PHONY: all run build build_run down clean fclean re
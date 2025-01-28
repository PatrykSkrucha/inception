COMPOSE= -f srcs/docker-compose.yml

all: build

run:
	@mkdir -p ./wp_vol
	@mkdir -p ./db_vol
	@docker compose ${COMPOSE} up -d

build:
	@mkdir -p ./wp_vol
	@mkdir -p ./db_vol
	@docker compose ${COMPOSE} build --no-cache --pull

build_run: build run

down:
	@docker compose ${COMPOSE} down

clean:
	@docker compose ${COMPOSE} down --volumes --rmi all --remove-orphans

fclean: clean
	@docker system  ${COMPOSE}prune --all
	@docker builder ${COMPOSE} prune --all
	@sudo rm -rf db_vol
	@sudo rm -rf wp_vol

re: fclean run

.PHONY: all run build build_run down clean fclean re
COMPOSE= -f srcs/docker-compose.yml

all: build

run:
	@mkdir -p /home/pskrucha/data/wp_vol
	@mkdir -p /home/pskrucha/data/db_vol
	@docker compose ${COMPOSE} up -d

build:
	@mkdir -p /home/pskrucha/data/wp_vol
	@mkdir -p /home/pskrucha/data/db_vol
	@docker compose ${COMPOSE} build --no-cache --pull

build_run: build run

down:
	@docker compose ${COMPOSE} down

clean:
	@docker compose ${COMPOSE} down --volumes --rmi all --remove-orphans

fclean: clean
	@docker system prune --all
	@docker builder prune --all
	@sudo rm -rf /home/pskrucha/data

re: fclean run

.PHONY: all run build build_run down clean fclean re
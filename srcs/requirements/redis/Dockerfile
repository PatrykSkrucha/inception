FROM debian:bullseye

RUN apt update && apt install -y redis-server && rm -rf /var/lib/apt/lists/*

COPY conf/redis.conf /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y  && \
    apt-get clean && \
    apt install mariadb-server -y

COPY tools/init.sh /init.sh

COPY conf/my.cnf /etc/mysql/mariadb.conf.d/99-my.cnf

RUN chmod +x /init.sh

CMD ["/init.sh"]

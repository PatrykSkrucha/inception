FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysql \
	php-redis \
	php-cli \
	php-curl \
	php-gd \
	php-mbstring \
	php-xml \
	php-zip \
	php-bcmath \
	php-intl \
    curl \
    tar \
    unzip \
	netcat \
    && apt-get clean 

COPY tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ENTRYPOINT ["/usr/local/bin/init.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]

FROM debian:bullseye

# Install necessary PHP packages for Adminer
RUN apt-get update && apt-get install -y \
    php-fpm\
    php-mysqli \
    php-pdo \
    #php-common \
    curl \
    && apt-get clean

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# Create directory for Adminer and download the latest Adminer version
RUN mkdir -p /var/www/html/adminer \
    && curl -o /var/www/html/adminer/index.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php \
	&& mkdir -p /run/php
	# Set appropriate permissions for the directory
	
RUN chown -R www-data:www-data /var/www/html/adminer \
	&& chown -R www-data:www-data /run/php

#CMD ["php", "-S", "0.0.0.0:9001", "-t", "/var/www/html/adminer"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]

#FROM debian:bullseye

## Install necessary PHP and PHP-FPM packages
#RUN apt-get update && apt-get install -y \
#    php-fpm \
#    php-mysqli \
#    php-pdo \
#    php-cli \
#    php-common \
#    curl \
#    && apt-get clean


## Create directory for Adminer and download the latest Adminer version
#RUN mkdir -p /var/www/html/adminer \
#	&& mkdir -p /run/php \
#    && curl -o /var/www/html/adminer/index.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php

## Set appropriate permissions
#RUN chown -R www-data:www-data /var/www/html/adminer \
#	&& chown -R www-data:www-data /run/php

# Expose PHP-FPM on port 9001
#RUN sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9001|" /etc/php/7.4/fpm/pool.d/www.conf

# Start PHP-FPM
#CMD ["php-fpm", "-F"]
#CMD ["/usr/sbin/php-fpm7.4", "-F"]

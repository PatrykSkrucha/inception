#FROM debian:bullseye

#RUN apt-get update && apt-get install -y \
#    php \
#    php-mysqli \
#    php-pdo \
#    php-cli \
#    php-common \
#    curl \
#    && apt-get clean

#RUN mkdir -p /var/www/html \
#    && curl -o /var/www/html/index.php https://www.adminer.org/latest.php

#RUN chown -R www-data:www-data /var/www/html

#CMD ["php", "-S", "0.0.0.0:9000", "-t", "/var/www/html"]

FROM debian:bullseye

# Install necessary PHP packages for Adminer
RUN apt-get update && apt-get install -y \
    php \
    php-mysqli \
    php-pdo \
    php-cli \
    php-common \
    curl \
    && apt-get clean

# Create directory for Adminer and download the latest Adminer version
RUN mkdir -p /var/www/html/adminer \
    && curl -o /var/www/html/adminer/index.php https://www.adminer.org/static/download/4.8.1/adminer-4.8.1.php

# Set appropriate permissions for the directory
RUN chown -R www-data:www-data /var/www/html/adminer

# No need for the PHP built-in server, as NGINX will route requests to PHP-FPM in WordPress
CMD ["php", "-S", "0.0.0.0:9000", "-t", "/var/www/html/adminer"]

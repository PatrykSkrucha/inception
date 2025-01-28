# Use Debian Bullseye as base
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    curl \
    tar \
    unzip \
	netcat \
    && apt-get clean 

# Copy entrypoint script and make it executable
COPY tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/init.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]

## Start PHP-FPM


#FROM debian:bullseye

## Set environment variables to prevent interactive prompts during package installation
#ENV DEBIAN_FRONTEND=noninteractive

## Update package list and upgrade system packages
#RUN apt-get update && apt-get upgrade -y  && \
#    apt-get clean

## Define the default command
#CMD ["tail", "-f", "/dev/null"]

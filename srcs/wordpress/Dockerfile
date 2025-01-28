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
COPY init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set entrypoint
CMD ["/usr/local/bin/init.sh"]

## Start PHP-FPM


#FROM debian:bullseye

## Set environment variables to prevent interactive prompts during package installation
#ENV DEBIAN_FRONTEND=noninteractive

## Update package list and upgrade system packages
#RUN apt-get update && apt-get upgrade -y  && \
#    apt-get clean

## Define the default command
#CMD ["tail", "-f", "/dev/null"]

# Start with the Debian Bullseye base image
FROM debian:bullseye

# Install NGINX
RUN apt-get update && apt-get install -y \
    nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy a custom NGINX configuration to enforce TLS 1.3
COPY nginx.conf /etc/nginx/conf.d/my.conf

COPY ssl-certs /etc/ssl/certs/

# Start NGINX as the default command
CMD ["nginx", "-g", "daemon off;"]

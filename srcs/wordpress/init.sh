#!/bin/bash
set -e

mkdir -p /run/php
chown -R www-data:www-data /run/php

if [ ! -e /var/www/html/$DOMAIN_NAME/.wordpress_setup_done ]; then	
	mkdir -p /var/www/html/$DOMAIN_NAME
	chown -R www-data:www-data /var/www/html/$DOMAIN_NAME
	chmod -R 755 /var/www/html/$DOMAIN_NAME
	cd /var/www/html/$DOMAIN_NAME

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	chmod +x /usr/local/bin/wp


	sleep 10
	until nc -z $DB_HOST $DB_PORT; do echo 'Waiting db...' >>output && sleep 5; done
    
	
	if [ ! -f /var/www/html/$DOMAIN_NAME/wp-config.php ]; then
    	echo "Downloading WordPress..."
    	wp core download --allow-root

# Check if WordPress is already installed
	#wp core is-installed --path=/var/www/html --allow-root; then
    	echo "Creating wp-config.php..."
    	wp config create \
			--path=/var/www/html/$DOMAIN_NAME \
    	    --dbname="$DB_NAME" \
    	    --dbuser="$WORDPRESS_DB_USER" \
    	    --dbpass="$WORDPRESS_DB_PASSWORD" \
    	    --dbhost="$DB_HOST:$DB_PORT" \
    	    --allow-root

    	echo "Installing WordPress..."
    	wp core install \
			--path=/var/www/html/$DOMAIN_NAME \
    	    --url="$DOMAIN_NAME/" \
    	    --title="Inception" \
    	    --admin_user="$WORDPRESS_ADMIN_USER" \
    	    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    	    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    	    --allow-root

    	echo "Creating additional user..."
    	wp user create "$WORDPRESS_DB_USER" "$WORDPRESS_DB_EMAIL" \
			--path=/var/www/html/$DOMAIN_NAME \
    	    --role=editor \
    	    --user_pass="$WORDPRESS_DB_PASSWORD" \
		    --allow-root
    fi

    touch /var/www/html/$DOMAIN_NAME/.wordpress_setup_done
else
    echo "WordPress already exists. Skipping download."
fi


# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F

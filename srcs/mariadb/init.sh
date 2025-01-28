#!/bin/bash
set -e

# Check if database is empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background to set up users and database
mysqld_safe --skip-networking &

echo "Waiting for MariaDB to start..."
until mariadb-admin ping --silent; do
    sleep 1
done

echo "Configuring database..."
mariadb -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
    CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "DB configured."
# Stop background MariaDB process
mysqladmin shutdown

# Start MariaDB normally
exec mysqld

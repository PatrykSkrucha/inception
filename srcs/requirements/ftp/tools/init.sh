#!/bin/sh

# Ensure /etc/vsftpd/ exists
mkdir -p /etc/vsftpd/

# Move the vsftpd.conf file
mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

# Ensure the user exists
adduser --disabled-password --gecos "" "$WORDPRESS_DB_USER"

# Set the password
echo "$WORDPRESS_DB_USER:$WORDPRESS_DB_PASSWORD" | chpasswd

chmod +x /etc/vsftpd/vsftpd.conf
# Start vsftpd
exec "$@"


#if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

#    mkdir -p /var/www/html

#    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
#    mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

#    # Add the FTP_USER, change his password and declare him as the owner of wordpress folder and all subfolders
#    adduser $WORDPRESS_DB_USER --disabled-password
#    echo "$WORDPRESS_DB_USER:$WORDPRESS_DB_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
#    chown -R $WORDPRESS_DB_USER:$WORDPRESS_DB_USER /var/www/html

#    echo $WORDPRESS_DB_USER | tee -a /etc/vsftpd.userlist &> /dev/null

#fi

#echo "FTP started on :21"
#/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf


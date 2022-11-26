#!/bin/bash

# shell variable for domain name
DOMAIN_NAME="osticket.skystrength.com"

# update apt software package listings
sudo apt update

# upgrade installed packages
sudo apt upgrade -y

# install apache2
sudo apt install -y apache2

# install php and php modules asked for by osticket
sudo apt install -y \
    php \
    libapache2-mod-php \
    php-mysql \
    php-common \
    php-gd \
    php-imap \
    php-intl \
    php-apcu \
    php-cli \
    php-mbstring \
    php-curl \
    php-json \
    php-xml

# download osticket v1.17.2 to home directory
wget https://github.com/osTicket/osTicket/releases/download/v1.17.2/osTicket-v1.17.2.zip -O ~/osTicket-v1.17.2.zip

# temporarily take ownership of apache web directories
sudo chown -R $USER:$USER /var/www

# unzip osticket and create webroot directory
unzip ~/osTicket-v1.17.2.zip -d /var/www/osticket

# move core osticket website files to new webroot directory
mv /var/www/osticket/upload/* /var/www/osticket

# use config template to create main osticket config file needed by setup wizard
cp /var/www/osticket/include/ost-sampleconfig.php /var/www/osticket/include/ost-config.php

# create apache2 vhost configuration file for osticket website
cat << EOF > ~/${DOMAIN_NAME}.conf
<VirtualHost *:80>
    ServerAdmin jhillman@lbcc.edu
    ServerName ${DOMAIN_NAME}
    ServerAlias www.${DOMAIN_NAME}
    DocumentRoot /var/www/osticket
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# move vhost config file to sites-available so it can be enabled
sudo cp ~/${DOMAIN_NAME}.conf /etc/apache2/sites-available/${DOMAIN_NAME}.conf

# enable new osticket website
sudo a2ensite ${DOMAIN_NAME}

# disable default apache website
sudo a2dissite 000-default.conf

# verify changes to apache configuration
sudo apache2ctl configtest

# set permissions on apache website files (owner=rwx / everyone=rx)
sudo chmod -R 755 /var/www

# temporarily enable read/write on osticket config file to ensure setup wizard operability
sudo chmod 0666 /var/www/osticket/include/ost-config.php

# return ownership of apache site files back to apache user (www-data)
sudo chown -R www-data:www-data /var/www

# restart apache2 daemon to apply all changes
sudo systemctl restart apache2

# configure firewall to allow ssh traffic (22)
sudo ufw allow "OpenSSH"

# configure firewall to allow http/https traffic (80/443)
sudo ufw allow "Apache Full"

# enable firewall and set to start automatically on boot
sudo ufw enable

# install certbot and certbot module for apache webservers
sudo apt install -y \
    certbot \
    python3-certbot-apache

# use certbot to install let's encrypt ssl certificate
sudo certbot --apache

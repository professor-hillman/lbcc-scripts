#!/bin/bash

# shell variable for mysql passwords
PW_MYSQL_ROOT='CHANGE_ME'
PW_MYSQL_OST='CHANGE_ME'

# shell variable for webserver ip address
WEBSVR_IP='10.0.5.20'

# update apt software package listings
sudo apt update

# upgrade installed packages
sudo apt upgrade -y

# mysql_secure install / change to native password auth / osticket database setup
sudo mysql << EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${PW_MYSQL_ROOT}';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE osticketdb;
CREATE USER 'osticket'@'${WEBSVR_IP}' IDENTIFIED WITH mysql_native_password BY '${PW_MYSQL_OST}';
GRANT ALL ON osticketdb.* TO 'osticket'@'${WEBSVR_IP}';
FLUSH PRIVILEGES;
EOF

# modify mysql config to bind daemon to all interfaces (enable remote access)
sudo sed -i 's|127\.0\.0\.1|0\.0\.0\.0|g' /etc/mysql/mysql.conf.d/mysqld.cnf

# restart mysql daemon to initialize configuration changes
sudo systemctl restart mysql

# configure firewall to allow ssh traffic from webserver ONLY
sudo ufw allow from ${WEBSVR_IP} proto tcp to any port 22

# configure firewall to allow mysql traffic from webserver ONLY
sudo ufw allow from ${WEBSVR_IP} proto tcp to any port 3306

# enable firewall and set to start automatically on boot
sudo ufw enable

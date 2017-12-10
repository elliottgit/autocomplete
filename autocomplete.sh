#!/bin/bash
#title:         gcp.sh
#description:   Bash script to complete GCP demo.
#author:        Elliott Ning
#date:          20171209
#version:       0.9
#=======================================================


# download and install apache
read -rsp $'\nStep 1: Install Apache web server, press any key to continue\n' -n1 key
#apt-get update
apt-get -y install apache2


# set firewall rules to allow ssh and http
read -rsp $'\nStep 2: Set operating system firewall, press any key to continue\n' -n1 key
ufw allow ssh
ufw allow 'Apache Full'
ufw disable
yes | ufw enable


# install php and modules
read -rsp $'\nStep 3: Install PHP modules, press any key to continue\n' -n1 key
apt-get -y install php libapache2-mod-php php-mcrypt php-mysql
systemctl start apache2
systemctl enable apache2
#systemctl restart apache2


# install and configure mysql
read -rsp $'\nStep 4: Install Mysql database, press any key to continue\n' -n1 key
apt-get -y install mysql-server
#mysql_secure_installation


# create database and import data
read -rsp $'\nStep 5: Create database and import the demo data, press any key to continue\n' -n1 key
mysql -uroot -ppassword -e "CREATE DATABASE gcp"
mysql -uroot -ppassword -e "
USE gcp
CREATE TABLE products (
sku INT(10),
product VARCHAR(200),
type VARCHAR(20),
price DECIMAL(10,2),
upc INT(20),
category1 VARCHAR(50),
category2 VARCHAR(50),
category3 VARCHAR(50),
shipping DECIMAL(10,2),
description TEXT,
manufacturer VARCHAR(50),
model VARCHAR(50),
url TEXT
)"
mysql -uroot -ppassword -e "
USE gcp
LOAD DATA LOCAL INFILE '/home/elliottning/gcp/products.csv' 
INTO TABLE products 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS"


# copy indexs and relevant files
read -rsp $'\nStep 6: Copy index page and search file, press any key to continue\n' -n1 key
wget https://objectstorage.us-phoenix-1.oraclecloud.com/p/cGDUptYdMuYizRCuGp3uFihqts4Xr7xuO0cF9KGNjbw/n/oraclemichaelme/b/image/o/home.jpg
mv /var/www/html/index.html /var/www/html/defaultindex
mv /home/elliottning/gcp/index.php /var/www/html
mv /home/elliottning/gcp/search.php /var/www/html
mv /home/elliottning/gcp/home.jpg /var/www/html
systemctl restart apache2

# ===display url for web page===
echo -e "\nEnter the URL below in your browser to see the website:"
IP=`wget http://ipecho.net/plain -O - -q ; echo`
echo "http://$IP"

#EOF

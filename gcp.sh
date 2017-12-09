#!/bin/bash
#title:         gcp.sh
#description:   Bash script to complete GCP demo.
#author:        Elliott Ning
#date:          20171208
#version:       0.8
#=======================================================

# download realted files
git clone https://github.com/elliottgit/gcp.git


# download and install apache
read -rsp $'Download and install Apache web server, press any key to continue\n' -n1 key
apt-get update
apt-get -y install apache2


# set firewall rules to allow ssh and http
read -rsp $'Allow relevant ports and enable OS firewall, press any key to continue\n' -n1 key
ufw allow ssh
ufw allow 'Apache Full'
ufw disable
yes | ufw enable


# install php and modules
read -rsp $'Install PHP related modules and restart Apache, press any key to continue\n' -n1 key
apt-get -y install php libapache2-mod-php php-mcrypt php-mysql
systemctl start apache2
systemctl enable apache2
#systemctl restart apache2


# install and configure mysql
read -rsp $'Install and configure Mysql database, press any key to continue\n' -n1 key
apt-get -y install mysql-server
# configure mysql
mysql_secure_installation


# create database and import data
read -rsp $'Create database gcp and import the demo data, press any key to continue\n' -n1 key
mysql -uroot -ppassword -e "CREATE DATABASE gcp"
mysql -uroot -ppassword gcp < /home/ubuntu/gcp/countries.sql
#mysql -u root -p password gcp < /home/elliottning/countries.sql 


# copy indexs and relevant files
read -rsp $'Copy index page and relevant files, press any key to continue\n' -n1 key
mv /var/www/html/index.html /var/www/html/index.default
mv /home/ubuntu/gcp/index.php /var/www/html
mv /home/ubuntu/gcp/search.php /var/www/html


# ===display url for web page===
echo "Enter the URL below in your browser to see the website:"
IP=`wget http://ipecho.net/plain -O - -q ; echo`
echo "http://$IP"

#EOF

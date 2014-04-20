#!/bin/bash
# Viernes, Abril 11/2014
# Script para instalar nginx
# Developed by abr4xas <me@abr4xas.org>
# Source: https://www.digitalocean.com/community/articles/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-12-04

if [[ $USER != root ]]; then
	echo "##########################################"
	echo "# Error: You must have ROOT privileges  ##"
	echo "##########################################"
   exit 1
fi
apt-get update
apt-get install -y mysql-server php5-mysql
mysql_install_db
/usr/bin/mysql_secure_installation
apt-get install -y nginx
service nginx start
# You can confirm that nginx has installed an your web server by directing your browser to your IP address. 
# You can run the following command to reveal your VPS's IP address.
ifconfig eth0 | grep inet | awk '{ print $2 }'
apt-get install -y php5-fpm
echo "Find the line, cgi.fix_pathinfo=1, and change the 1 to 0."
echo "cgi.fix_pathinfo=0"
echo "Ready? type: y"
read continue
if [[ $continue = y]]; then
    nano /etc/php5/fpm/php.ini
fi
echo "We need to make another small change in the php5-fpm configuration."
echo "Find the line, listen = 127.0.0.1:9000, and change the 127.0.0.1:9000 to /var/run/php5-fpm.sock."
echo "Ready? type: y"
read continue
if [[ $continue = y]]; then
    nano /etc/php5/fpm/pool.d/www.conf
fi
service php5-fpm restart
echo "Configure nginx"
nano /etc/nginx/sites-available/default
echo "<?php phpinfo(); ?>"  >> /usr/share/nginx/html/info.php
service nginx restart
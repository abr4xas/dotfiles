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
aptitude update
aptitude install -y mysql-server php5-mysql
mysql_install_db
/usr/bin/mysql_secure_installation
aptitude install -y nginx
service nginx start
aptitude install -y php5-fpm

echo "cgi.fix_pathinfo=0" >> nano /etc/php5/fpm/php.ini
service php5-fpm restart
echo "<?php phpinfo(); ?>"  >> /usr/share/nginx/html/info.php
service nginx restart

exit 0
#!/bin/bash
# Martes, Abril 29/2014
# Script para NGNIX - PHP - MySQL
# Developed by abr4xas <me@abr4xas.org>

if [[ $USER != root ]]; then
	echo "##########################################"
	echo "# Error: Debe tener privilegios de ROOT ##"
	echo "##########################################"
   exit 1
fi
aptitude update -y
aptitude install -y nginx mysql-server php5-mysql php5-fpm javascript-common libhtml-template-perl php5-gd
service nginx start
mysql_install_db
/usr/bin/mysql_secure_installation
service nginx restart
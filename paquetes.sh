#!/bin/bash
# Viernes, Abril 11/2014
# Script para instalar solo los paquetes necesarios para mi equipo
# Developed by abr4xas <me@abr4xas.org>

if [[ $USER != root ]]; then
	echo "##########################################"
	echo "# Error: Debe tener privilegios de ROOT ##"
	echo "##########################################"
   exit 1
fi
apt-get update -q
apt-get update -y
## Alguna dependencia rota
apt-get install -f
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y git nodejs irssi filezilla ruby2.0 libreoffice-l10n-es apache2 mysql-server php5 php5-mysql php5-cli php5-imagick php5-gd php5-mcrypt php5-curl php5-readline phpmyadmin
gem install sass

apt-get autoremove -y

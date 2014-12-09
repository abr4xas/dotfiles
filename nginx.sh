#!/bin/bash
# Martes, Diciembre 09/2014
# Script para instalar nginx
# Developed by abr4xas <me@abr4xas.org>
#

if [[ $USER != root ]]; then
        echo "##########################################"
        echo "# Error: You must have ROOT privileges  ##"
        echo "##########################################"
   exit 1
fi

echo "############################"

apt-get install nginx -y
service nginx start
update-rc.d nginx defaults
echo " "
echo " "
echo " Ahora vamos a configurar los Virtual Hosts "
echo " "
echo " "

echo " Ingrese el nombre del dominio a crear. Ej: dominio.com"
read MY_VH
mkdir -p /var/www/$MY_VH/public_html
chown -R www-data:www-data /var/www/$MY_VH/public_html
chmod 755 /var/www
echo "Success: You Have Set Up a Virtual Host" >> /var/www/example.com/$MY_VH/index.html
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$MY_VH



exit 0

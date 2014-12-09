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

exit 0

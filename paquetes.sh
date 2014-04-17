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
apt-get install -f
apt-get install -y -t experimental iceweasel git flashplugin-nonfree firmware-linux firmware-linux-free firmware-linux-nonfree firmware-realtek linux-wlan-ng
apt-get autoremove -y
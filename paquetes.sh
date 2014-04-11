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
apt-get install -y git flashplugin-nonfree firmware-linux firmware-linux-free firmware-linux-nonfree firmware-realtek linux-wlan-ng -t experimental iceweasel
apt-get autoremove -y

echo "Cual es el RELEASE de Brackets(ir a http://brackets.io/)"
read release
wget -c https://github.com/adobe/brackets/releases/download/sprint-$release/Brackets.Sprint.$release.64-bit.deb
dpkg -i Brackets.Sprint.$release.64-bit.deb


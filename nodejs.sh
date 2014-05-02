#!/bin/bash
# Viernes, Abril 11/2014
# Script para instalar nodejs
# Developed by abr4xas <me@abr4xas.org>
# Source: http://developwithguru.com/how-to-install-node-js-and-npm-in-ubuntu-or-mint/
if [[ $USER != root ]]; then
	echo "##########################################"
	echo "# Error: You must have ROOT privileges  ##"
	echo "##########################################"
   exit 1
fi
apt-get remove nodejs nodejs-dev npm
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install nodejs
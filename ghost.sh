#!/bin/bash
# Viernes, Abril 11/2014
# Script para instalar nodejs
# Developed by abr4xas <me@abr4xas.org>
# Source: http://developwithguru.com/how-to-install-node-js-and-npm-in-ubuntu-or-mint/


curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
unzip -uo ghost.zip -d ghost
cd ghost
npm install --production
npm start
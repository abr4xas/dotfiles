#!/bin/bash
#
# Viernes, Abril 11/2014
# Developed by abr4xas <me@abr4xas.org>

if [[ $USER = root ]]; then
	echo "#############################################"
	echo "## No es recomendable ejecutar este script ##"
	echo "## con permisos de ROOT			   ##"
	echo "#############################################"
	exit 1
fi

if [ -e ~/.gitconfig ]; then
	rm ~/.gitconfig
	ln -s $PWD/gitconfig ~/.gitconfig
   else
	ln -s $PWD/gitconfig ~/.gitconfig
fi
if [ -e ~/.irssi/config ]; then
	rm ~/.irssi/config
	ln -s $PWD/config ~/.irssi/config
   else
	ln -s $PWD/config ~/.irssi/config
fi
if [ -e ~/.gitignore ]; then
	rm ~/.gitignore
	ln -s $PWD/gitignore ~/.gitignore
   else
	ln -s $PWD/gitignore ~/.gitignore
fi
echo "Finalizado"
exit 0;

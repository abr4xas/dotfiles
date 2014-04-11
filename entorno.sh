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
fi
if [ -e ~/.irssi/config ]; then
	rm ~/.irssi/config
	ln -s $PWD/config ~/.irssi/config
fi
# ln -s $PWD/gitignore ~/.gitignore
echo "Finalizado"
exit 0;

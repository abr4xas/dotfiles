#!/bin/bash
#
# Viernes, Abril 11/2014
# Developed by abr4xas <me@abr4xas.org>

if [[ $USER = root ]]; then
    echo "#############################################"
    echo "## No es recomendable ejecutar este script ##"
    echo "## este script con permisos de ROOT	     ##"
    echo "#############################################"
    exit 1
fi

wget -c https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm-zsh/master/honukai.zsh-theme > /dev/null 2>&1

if [ -e ~/.gitconfig ]; then
    rm ~/.gitconfig
    ln -s $PWD/gitconfig ~/.gitconfig
else
   ln -s $PWD/gitconfig ~/.gitconfig
fi
if [ -e ~/.zshrc ]; then
    rm ~/.zshrc
    ln -s $PWD/zshrc ~/.zshrc
else
    ln -s $PWD/zshrc ~/.zshrc
fi
if [ -e ~/.gitignore ]; then
    rm ~/.gitignore
    ln -s $PWD/gitignore ~/.gitignore
else
    ln -s $PWD/gitignore ~/.gitignore
fi
if [ -e ~/.gitmessage.txt ]; then
    rm ~/.gitmessage.txt
    ln -s $PWD/gitmessage.txt ~/.gitmessage.txt
else
    ln -s $PWD/gitmessage.txt ~/.gitmessage.txt
fi
if [ -e ~/.oh-my-zsh/themes/honukai.zsh-theme ]; then
    rm ~/.oh-my-zsh/themes/honukai.zsh-theme
    cp $PWD/honukai.zsh-theme ~/.oh-my-zsh/themes/honukai.zsh-theme
else
    cp $PWD/honukai.zsh-theme ~/.oh-my-zsh/themes/honukai.zsh-theme
fi
sleep 5

source ~/.zshrc

echo "Finalizado"
exit 0;

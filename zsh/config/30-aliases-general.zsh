# 30-aliases-general.zsh - General aliases

# Shell reload
alias reloadcli="source $HOME/.zshrc"

# Navigation
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias home='cd ~'

# File management
alias l="ls -laF"
alias c="clear"

# System configuration
alias hostfile="sudo nano /etc/hosts"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Development
alias phpserver="php -S localhost:8888"

# Utilities
alias publickey="pbcopy < ~/.ssh/id_rsa.pub"
alias _='sudo '
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

# Homebrew
alias brewall="brew update && brew upgrade && brew cleanup"

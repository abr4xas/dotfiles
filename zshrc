# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7
# GPG signing fix (?)
# export GPG_TTY=$(tty)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

#Theme
ZSH_THEME=honukai

#Source
source $ZSH/oh-my-zsh.sh

#
# path
export PATH=$PATH:~/flutter/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Crear un directorio con el nombre que le pasemos por ($1) y luego cambiamos al directorio
function create() {
  mkdir $1 && cd $1
}

extract () {
      if [ -f $1 ] ; then
        case $1 in
          *.tar.bz2)   tar xjf $1   ;;
          *.tar.gz)    tar xzf $1   ;;
          *.bz2)       bunzip2 $1   ;;
          *.rar)       unrar x $1   ;;
          *.gz)        gunzip $1    ;;
          *.tar)       tar xf $1    ;;
          *.tbz2)      tar xjf $1   ;;
          *.tgz)       tar xzf $1   ;;
          *.zip)       unzip $1     ;;
          *.Z)         uncompress $1;;
          *.7z)        7z x $1      ;;
          *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
      else
        echo "'$1' is not a valid file"
      fi
}

#
# docker
dbuild() {
  docker-compose build
}
dstart() {
  docker-compose up -d
}
dexec() {
  docker-compose exec $1 bash
}
dstop () {
  docker-compose stop
}
mysqlIp() {
  docker exec $1 ping mysql
}
mariaIp() {
  docker exec $1 ping mariadb
}
ddall () {
  docker stop $(docker ps -a -q)
  docker rm -f $(docker ps -a -q)
  docker rmi $(docker images -q)
  docker rm -v $(docker ps -a -q)
}

#macro to kill the docker desktop app and the VM (excluding vmnetd -> it's a service)
function kdo() {
 ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill
}

dbranch () {
  git branch | grep -v $1 | xargs git branch -D
}

function whatthecommit() {
  curl --silent --fail https://whatthecommit.com/index.txt
}

#
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# GO
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
alias gr="go run"

#
# Custom git aliases
alias nope='git reset --hard;git clean -df'
alias pushlive="git push origin master && git push live master"
alias pushmaster='git push origin master'
alias pom="git pull origin master"
alias gclean='g clean -df' # Remove all untracked files & directories
alias wip="git add . && git commit -m ' Fixed what needed fixing and squished some bugs. :bug:'"
alias fix="git diff --name-only | uniq | xargs code"0
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias undocommit="git reset HEAD~1"
alias yolo="git add . && git commit -m \"$(whatthecommit)\""
alias donetoday="git add . && git commit -m 'To be honest, I do not quite remember everyting I changed here today ¯\_(ツ)_/¯ But it is all good, I tell ya.'"

#
# composer
alias climb="composer outdated --outdated --direct" #https://jenssegers.com/83/list-outdated-composer-packages
alias cdo="composer dump-autoload -o"
alias update-global-composer='cd ~/.composer && composer update'
alias cgu='update-global-composer'
alias ci='composer install'
alias cu='composer update'

#
# Misc
alias reloadcli="source $HOME/.zshrc"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias hostfile="sudo nano /etc/hosts"
alias phpserver="php -S localhost:8888"
alias publickey="pbcopy < ~/.ssh/id_rsa.pub"
alias _='sudo '
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias l="ls -laF"
alias brewall="brew update && brew upgrade && brew cleanup"
alias home='cd ~'

#
# phpstorm
alias storm='open -a /Applications/PhpStorm.app "`pwd`"'

#
# Laravel
alias art="php artisan"
alias tinker='php artisan tinker'
alias sail='bash vendor/bin/sail'
alias envoy="php vendor/bin/envoy"
alias routelist='php artisan route:list'
alias mfs="php artisan migrate:fresh --seed"
alias pint="composer format"

#
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

#
# Lock the screen
alias afk="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"

# Run tests
function p() {
   if [ -f vendor/bin/pest ]; then
      vendor/bin/pest "$@"
   else
      vendor/bin/phpunit "$@"
   fi
}

function pf() {
   if [ -f vendor/bin/pest ]; then
      vendor/bin/pest --filter "$@"
   else
      vendor/bin/phpunit --filter "$@"
   fi
}

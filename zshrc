# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7
# GPG signing fix (?)
export GPG_TTY=$(tty)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

#Theme
ZSH_THEME=honukai

#Source
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# Run a local server on current folder
function server() {
  if [ $1 ]
  then
    local port="$1"
  else
    local port="8000"
  fi
  google-chrome "http://0.0.0.0:$port" && python -m SimpleHTTPServer "$port"
}
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
# youtube-dl
#

musica () {
  youtube-dl -x --audio-format mp3 $1
}

video () {
  youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' --merge-output-format=mp4 $1
}

homestead () {
  cd ~/Homestead && vagrant halt && vagrant reload --provision && vagrant ssh
}
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

dbranch () {
  git branch | grep -v $1 | xargs git branch -D
}


#
# Ayuda
#

myHelp() { 
  echo 'Ayuda para el plugin de GIT'
  echo 'gl => git pull $(current_branch)'
  echo 'gp => git push origin $(current_branch)'
  echo 'gca => git commit -v -a'
  echo 'gcm => git checkout master'
  echo 'gba => git branch -a'
  echo 'glgg => git log --graph --max-count=5'
  echo 'grh => git reset HEAD'
  echo 'gdv => git diff -w "$@" | view -'
  echo 'gss => git status -s'
  echo 'ddall => elimina cosas de docker'
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#android
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

#composer stuff xD
export PATH="$HOME/.composer/vendor/bin:$PATH"

#
# GO 
export PATH=$PATH:/usr/local/go/bin

#
# mssql
export PATH=$PATH:/opt/mssql-tools/bin

# Custom git aliases
alias nope='git reset --hard;git clean -df'
alias pushlive="git push origin master && git push live master"
alias pushmaster='git push origin master'
alias pom="git pull origin master"
alias gclean='g clean -df' # Remove all untracked files & directories
alias wip="git add . && git commit -m ' Fixed what needed fixing and squished some bugs. :bug:'"
alias fix="git diff --name-only | uniq | xargs code"
#
# other aliasses
alias _='sudo'
alias ll="ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F"

#
# composer
#
alias climb="composer outdated --outdated --direct" #https://jenssegers.com/83/list-outdated-composer-packages
alias cdo="composer dump-autoload -o"
alias update-global-composer='cd ~/.composer && composer update'
alias cgu='update-global-composer'
alias ci='composer install -vvv'
alias cu='composer update'
alias cuv='composer update -vvv'
alias ctest='composer run-script test'
#
#
alias reloadcli="source $HOME/.zshrc"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias remoteip="curl icanhazip.com"
alias open='xdg-open .'

#
# Laravel
alias art="php artisan"
alias mfs="php artisan migrate:fresh --seed"
alias tinker='php artisan tinker'
alias routelist='php artisan route:list'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

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
    echo "http://0.0.0.0:$port" && python -m SimpleHTTPServer "$port"
}
# Crear un directorio con el nombre que le pasemos por ($1) y luego cambiamos al directorio
function create() {
  mkdir $1
  cd $1
}

extract ()
    {
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
}

# nvm
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Other aliases
alias ll="ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F"
# Git aliases
alias vnd3x="git submodule foreach git pull origin master"
alias gclean='g clean -df' # Remove all untracked files & directories

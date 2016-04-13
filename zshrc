# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export UPDATE_ZSH_DAYS=7
plugins=(git)
source $ZSH/oh-my-zsh.sh
# User configuration
autoload -U colors promptinit && colors
TERM=xterm-256color

# Run a local server on current folder
function server() {
    if [ $1 ]
    then
        local port="$1"
    else
        local port="8000"
    fi
    echo "http://localhost:$port" && python -m SimpleHTTPServer "$port"
}
# Crear un directorio con el nombre que le pasemos por ($1) y luego cambiamos al directorio
function create() {
  mkdir $1
  cd $1
}
# Pasamos por ($1) la descripcion del commit se debe inclir las comillas dobles
function gpush(){
    git add . && git commit -am $1 && git push origin master
}
# Prompt
PROMPT="
$fg[red]%n$reset_color@$fg[yellow]%m$reset_color: $fg[green]%~$reset_color
$fg[green]>$reset_color "

# Other aliases
alias ll="ls -al"
alias vup='vagrant up && vagrant ssh'
# Git aliases
alias vnd3x="git submodule foreach git pull origin master && git pull origin master"
alias gclean='g clean -df' # Remove all untracked files & directories

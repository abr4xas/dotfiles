# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="nico"
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
    open "http://localhost:$port" && python -m SimpleHTTPServer "$port"
}
# Crear un directorio con el nombre que le pasemos por ($1) y luego cambiamos al directorio
function create() {
  mkdir $1
  cd $1
}
# Pasamos por ($1) la descripcion del commit se debe inclir las comillas dobles
function gpush(){
    git log --graph --pretty=format:'%Cred%h%Creset - %C(green)%an%Creset - %C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative > CHANGELOG && git add . && git commit -am $1 && git push origin
}
# Prompt
PROMPT="
$fg[red]%n$reset_color@$fg[yellow]%m$reset_color: $fg[green]%~$reset_color
$fg[green]>$reset_color "

# alias
alias vnd3x='git submodule foreach git pull origin master && git pull origin master && git log > CHANGELOG && git add . && git commit -m "Actualizando repo" && git push origin master'
alias ll='ls -al'
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

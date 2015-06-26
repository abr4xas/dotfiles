# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="nico"
plugins=(git)
source $ZSH/oh-my-zsh.sh
# User configuration
autoload -U colors && colors
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
	git add . && git commit -am $1 && git push origin
}
# Prompt
PROMPT="
$fg[red]%n$reset_color@$fg[yellow]%m$reset_color: $fg[green]%~$reset_color
$fg[green]>$reset_color "
# alias
alias vnd3x='git submodule foreach git pull origin master && git pull origin master && git log > CHANGELOG && git add . && git commit -m "Actualizando repo" && git push origin master'
alias ll='ls -al'

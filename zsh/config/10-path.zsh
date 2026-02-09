# 10-path.zsh - PATH configuration and language tools

# General paths
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Flutter
export PATH=$PATH:~/flutter/bin

# Composer
export PATH="$HOME/.composer/vendor/bin:$PATH"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

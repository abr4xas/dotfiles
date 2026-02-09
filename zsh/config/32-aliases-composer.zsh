# 32-aliases-composer.zsh - Composer aliases

# Composer shortcuts
alias climb="composer outdated --outdated --direct" # https://jenssegers.com/83/list-outdated-composer-packages
alias cdo="composer dump-autoload -o"
alias ci='composer install'
alias cu='composer update'

# Global composer updates
alias update-global-composer='cd ~/.composer && composer update'
alias cgu='update-global-composer'

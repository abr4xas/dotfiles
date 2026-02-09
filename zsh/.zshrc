# ~/.zshrc - Main loader for modular dotfiles
# https://github.com/abr4xas/dotfiles

# Dotfiles directory
export DOTFILES_DIR="${HOME}/.dotfiles"

# Source all config modules in order
if [[ -d "${DOTFILES_DIR}/zsh/config" ]]; then
  for config in "${DOTFILES_DIR}"/zsh/config/*.zsh; do
    if [[ -r "$config" ]]; then
      source "$config"
    fi
  done
  unset config
fi

# Load local overrides (not version controlled)
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

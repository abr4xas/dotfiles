#!/usr/bin/env bash
# install.sh - Dotfiles installation script
# https://github.com/abr4xas/dotfiles

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${SCRIPT_DIR}"

# Source utilities
source "${SCRIPT_DIR}/scripts/utils.sh"
source "${SCRIPT_DIR}/scripts/backup.sh"
source "${SCRIPT_DIR}/scripts/symlink.sh"

# Configuration
BACKUP_DIR="${DOTFILES_DIR}/backups"
THEME_URL="https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm-zsh/master/honukai.zsh-theme"

# Options
DRY_RUN=false
SKIP_CONFIRM=false
VERBOSE=false

# Print usage
usage() {
  cat << EOF
Usage: $(basename "$0") [OPTIONS]

Install dotfiles with automatic backups and symlink management.

OPTIONS:
  -y, --yes           Skip confirmation prompts
  -d, --dry-run       Show what would be done without executing
  -v, --verbose       Show verbose output
  -h, --help          Show this help message

EXAMPLES:
  $(basename "$0")              # Interactive installation
  $(basename "$0") -y           # Install without prompts
  $(basename "$0") -d           # Preview changes

EOF
}

# Parse command line arguments
parse_args() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -y|--yes)
        SKIP_CONFIRM=true
        shift
        ;;
      -d|--dry-run)
        DRY_RUN=true
        shift
        ;;
      -v|--verbose)
        VERBOSE=true
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        log_error "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
  done
}

# Check requirements
check_requirements() {
  log_info "Checking requirements..."

  local missing_requirements=()

  # Check for required commands
  if ! command_exists "git"; then
    missing_requirements+=("git")
  fi

  if ! command_exists "curl"; then
    missing_requirements+=("curl")
  fi

  if ! command_exists "zsh"; then
    missing_requirements+=("zsh")
  fi

  # Check for Oh-My-Zsh
  if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    log_warning "Oh-My-Zsh is not installed"
    log_info "Install it first: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    missing_requirements+=("oh-my-zsh")
  fi

  if [[ ${#missing_requirements[@]} -gt 0 ]]; then
    log_error "Missing requirements: ${missing_requirements[*]}"
    return 1
  fi

  log_success "All requirements met"
  return 0
}

# Detect operating system
detect_os() {
  log_info "Detecting operating system..."

  if [[ "$OSTYPE" == "darwin"* ]]; then
    log_info "Operating System: macOS"
    return 0
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    log_info "Operating System: Linux"
    return 0
  else
    log_warning "Operating System: Unknown ($OSTYPE)"
    log_warning "Some features may not work correctly"
    return 0
  fi
}

# Install theme
install_theme() {
  log_info "Installing Honukai theme..."

  local theme_path="${HOME}/.oh-my-zsh/themes/honukai.zsh-theme"

  if [[ "$DRY_RUN" == "true" ]]; then
    log_info "[DRY-RUN] Would download theme to: ${theme_path}"
    return 0
  fi

  if curl -fsSL "$THEME_URL" -o "$theme_path"; then
    log_success "Theme installed successfully"
    return 0
  else
    log_error "Failed to download theme"
    return 1
  fi
}

# Create symlinks
create_dotfile_symlinks() {
  log_info "Creating symlinks..."

  local files=(
    "git/.gitconfig:${HOME}/.gitconfig"
    "git/.gitignore_global:${HOME}/.gitignore"
    "git/.gitmessage.txt:${HOME}/.gitmessage.txt"
    "zsh/.zshrc:${HOME}/.zshrc"
  )

  for file_mapping in "${files[@]}"; do
    local source="${DOTFILES_DIR}/${file_mapping%%:*}"
    local target="${file_mapping##*:}"

    if [[ "$DRY_RUN" == "true" ]]; then
      log_info "[DRY-RUN] Would create symlink: ${target} -> ${source}"
    else
      create_symlink "$source" "$target" "true"
    fi
  done
}

# Verify installation
verify_installation() {
  log_info "Verifying installation..."

  local files=(
    "${HOME}/.gitconfig"
    "${HOME}/.gitignore"
    "${HOME}/.gitmessage.txt"
    "${HOME}/.zshrc"
  )

  local all_ok=true

  for file in "${files[@]}"; do
    if [[ ! -L "$file" ]]; then
      log_error "Symlink not found: ${file}"
      all_ok=false
    fi
  done

  if [[ "$all_ok" == "true" ]]; then
    log_success "Installation verified successfully"
    return 0
  else
    log_error "Installation verification failed"
    return 1
  fi
}

# Main installation function
main() {
  parse_args "$@"

  echo ""
  log_info "==================================="
  log_info "  Dotfiles Installation Script"
  log_info "==================================="
  echo ""

  # Check if running as root
  if [[ $EUID -eq 0 ]]; then
    log_error "This script should not be run as root"
    exit 1
  fi

  # Check requirements
  if ! check_requirements; then
    exit 1
  fi

  # Detect OS
  detect_os

  echo ""
  log_info "Dotfiles directory: ${DOTFILES_DIR}"
  log_info "Backup directory: ${BACKUP_DIR}"
  echo ""

  # Confirm installation
  if [[ "$SKIP_CONFIRM" == "false" ]] && [[ "$DRY_RUN" == "false" ]]; then
    if ! confirm "Continue with installation?"; then
      log_info "Installation cancelled"
      exit 0
    fi
  fi

  # Create backup
  if [[ "$DRY_RUN" == "false" ]]; then
    log_info "Creating backup..."
    local backup_timestamp_dir=$(create_backup_dir "$BACKUP_DIR")

    # Backup existing files
    backup_file "${HOME}/.gitconfig" "$backup_timestamp_dir" || true
    backup_file "${HOME}/.gitignore" "$backup_timestamp_dir" || true
    backup_file "${HOME}/.gitmessage.txt" "$backup_timestamp_dir" || true
    backup_file "${HOME}/.zshrc" "$backup_timestamp_dir" || true

    log_success "Backup created at: ${backup_timestamp_dir}"
  fi

  # Install theme
  install_theme

  # Create symlinks
  create_dotfile_symlinks

  # Verify installation
  if [[ "$DRY_RUN" == "false" ]]; then
    verify_installation

    # Cleanup old backups
    cleanup_old_backups "$BACKUP_DIR" 5
  fi

  echo ""
  log_success "==================================="
  log_success "  Installation Complete!"
  log_success "==================================="
  echo ""
  log_info "Next steps:"
  log_info "  1. Restart your terminal or run: source ~/.zshrc"
  log_info "  2. Check the documentation in docs/ for reference"
  log_info "  3. Customize local settings in ~/.zshrc.local"
  echo ""

  if [[ "$DRY_RUN" == "true" ]]; then
    log_warning "This was a dry-run. No changes were made."
  fi
}

# Run main function
main "$@"

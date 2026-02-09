#!/usr/bin/env bash
# uninstall.sh - Dotfiles uninstallation script
# https://github.com/abr4xas/dotfiles

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${SCRIPT_DIR}"

# Source utilities
source "${SCRIPT_DIR}/scripts/utils.sh"

# Configuration
BACKUP_DIR="${DOTFILES_DIR}/backups"

# Print usage
usage() {
  cat << EOF
Usage: $(basename "$0") [OPTIONS]

Uninstall dotfiles and optionally restore from backup.

OPTIONS:
  -k, --keep-backups  Keep backup files after uninstallation
  -r, --restore       Restore from most recent backup
  -h, --help          Show this help message

EXAMPLES:
  $(basename "$0")              # Remove symlinks only
  $(basename "$0") -r           # Remove symlinks and restore from backup
  $(basename "$0") -r -k        # Restore from backup and keep backup files

EOF
}

# Options
KEEP_BACKUPS=false
RESTORE_BACKUP=false

# Parse command line arguments
parse_args() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -k|--keep-backups)
        KEEP_BACKUPS=true
        shift
        ;;
      -r|--restore)
        RESTORE_BACKUP=true
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

# Remove symlinks
remove_symlinks() {
  log_info "Removing symlinks..."

  local files=(
    "${HOME}/.gitconfig"
    "${HOME}/.gitignore"
    "${HOME}/.gitmessage.txt"
    "${HOME}/.zshrc"
  )

  for file in "${files[@]}"; do
    if [[ -L "$file" ]]; then
      log_info "Removing symlink: ${file}"
      rm "$file"
      log_success "Removed: ${file}"
    elif [[ -e "$file" ]]; then
      log_warning "Not a symlink (skipping): ${file}"
    else
      log_info "File does not exist (skipping): ${file}"
    fi
  done
}

# Restore from backup
restore_from_backup() {
  log_info "Restoring from backup..."

  # Find most recent backup
  if [[ ! -d "$BACKUP_DIR" ]]; then
    log_error "Backup directory does not exist: ${BACKUP_DIR}"
    return 1
  fi

  local latest_backup=$(ls -1t "$BACKUP_DIR" | head -n 1)

  if [[ -z "$latest_backup" ]]; then
    log_error "No backups found in: ${BACKUP_DIR}"
    return 1
  fi

  local backup_path="${BACKUP_DIR}/${latest_backup}"
  log_info "Restoring from: ${backup_path}"

  # Restore files
  local files=(
    ".gitconfig"
    ".gitignore"
    ".gitmessage.txt"
    ".zshrc"
  )

  for file in "${files[@]}"; do
    local source="${backup_path}/${file}"
    local target="${HOME}/${file}"

    if [[ -e "$source" ]]; then
      log_info "Restoring: ${file}"
      cp -r "$source" "$target"
      log_success "Restored: ${file}"
    else
      log_warning "Backup file not found: ${file}"
    fi
  done

  log_success "Restore complete"
}

# Remove backups
remove_backups() {
  log_info "Removing backup directory..."

  if [[ -d "$BACKUP_DIR" ]]; then
    rm -rf "$BACKUP_DIR"
    log_success "Backups removed"
  else
    log_info "No backup directory found"
  fi
}

# Main uninstallation function
main() {
  parse_args "$@"

  echo ""
  log_info "==================================="
  log_info "  Dotfiles Uninstallation Script"
  log_info "==================================="
  echo ""

  # Confirm uninstallation
  if ! confirm "Are you sure you want to uninstall dotfiles?"; then
    log_info "Uninstallation cancelled"
    exit 0
  fi

  # Remove symlinks
  remove_symlinks

  # Restore from backup if requested
  if [[ "$RESTORE_BACKUP" == "true" ]]; then
    restore_from_backup
  fi

  # Remove backups if not keeping them
  if [[ "$KEEP_BACKUPS" == "false" ]] && [[ "$RESTORE_BACKUP" == "false" ]]; then
    if confirm "Remove backup files?"; then
      remove_backups
    fi
  fi

  echo ""
  log_success "==================================="
  log_success "  Uninstallation Complete!"
  log_success "==================================="
  echo ""
  log_info "Your dotfiles have been uninstalled."

  if [[ "$RESTORE_BACKUP" == "true" ]]; then
    log_info "Previous configuration has been restored."
  fi

  if [[ "$KEEP_BACKUPS" == "true" ]] || [[ "$RESTORE_BACKUP" == "true" ]]; then
    log_info "Backups are still available in: ${BACKUP_DIR}"
  fi

  echo ""
}

# Run main function
main "$@"

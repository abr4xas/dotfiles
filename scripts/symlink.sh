#!/usr/bin/env bash
# symlink.sh - Symlink creation helper

# Source utilities
_SYMLINK_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${_SYMLINK_SCRIPT_DIR}/utils.sh"

# Create a symlink
create_symlink() {
  local source="$1"
  local target="$2"
  local force="${3:-false}"

  # Check if source exists
  if [[ ! -e "$source" ]]; then
    log_error "Source does not exist: ${source}"
    return 1
  fi

  # Check if target already exists
  if [[ -e "$target" ]] || [[ -L "$target" ]]; then
    if [[ "$force" == "true" ]]; then
      log_warning "Removing existing target: ${target}"
      rm -rf "$target"
    else
      log_warning "Target already exists: ${target}"
      return 1
    fi
  fi

  # Create symlink
  log_info "Creating symlink: ${target} -> ${source}"
  ln -s "$source" "$target"

  if [[ $? -eq 0 ]]; then
    log_success "Symlink created successfully"
    return 0
  else
    log_error "Failed to create symlink"
    return 1
  fi
}

# Verify symlink
verify_symlink() {
  local target="$1"
  local expected_source="$2"

  if [[ ! -L "$target" ]]; then
    log_error "Not a symlink: ${target}"
    return 1
  fi

  local actual_source=$(readlink "$target")

  if [[ "$actual_source" == "$expected_source" ]]; then
    log_success "Symlink verified: ${target} -> ${actual_source}"
    return 0
  else
    log_error "Symlink mismatch: expected ${expected_source}, got ${actual_source}"
    return 1
  fi
}

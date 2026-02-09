#!/usr/bin/env bash
# utils.sh - Shared utility functions for dotfiles scripts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Confirm action with user
confirm() {
  local prompt="$1"
  local default="${2:-n}"

  if [[ "$default" == "y" ]]; then
    prompt="$prompt [Y/n] "
  else
    prompt="$prompt [y/N] "
  fi

  read -p "$prompt" -n 1 -r
  echo

  if [[ "$default" == "y" ]]; then
    [[ ! $REPLY =~ ^[Nn]$ ]]
  else
    [[ $REPLY =~ ^[Yy]$ ]]
  fi
}

# Get timestamp for backups
get_timestamp() {
  date +"%Y%m%d_%H%M%S"
}

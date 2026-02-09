#!/usr/bin/env bash
# backup.sh - Backup utility functions

# Source utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/utils.sh"

# Backup a file or directory
backup_file() {
  local file="$1"
  local backup_dir="$2"

  if [[ -e "$file" ]] || [[ -L "$file" ]]; then
    local basename=$(basename "$file")
    local backup_path="${backup_dir}/${basename}"

    log_info "Backing up ${file} to ${backup_path}"

    # Remove existing symlink or copy file/directory
    if [[ -L "$file" ]]; then
      rm "$file"
    else
      cp -r "$file" "$backup_path"
    fi

    return 0
  fi

  return 1
}

# Create backup directory with timestamp
create_backup_dir() {
  local base_backup_dir="$1"
  local timestamp=$(get_timestamp)
  local backup_dir="${base_backup_dir}/${timestamp}"

  mkdir -p "$backup_dir"
  echo "$backup_dir"
}

# Clean up old backups (keep only last N)
cleanup_old_backups() {
  local backup_dir="$1"
  local keep_count="${2:-5}"

  if [[ ! -d "$backup_dir" ]]; then
    return 0
  fi

  local backup_count=$(ls -1 "$backup_dir" | wc -l | tr -d ' ')

  if [[ $backup_count -gt $keep_count ]]; then
    log_info "Cleaning up old backups (keeping last ${keep_count})"

    ls -1t "$backup_dir" | tail -n +$((keep_count + 1)) | while read old_backup; do
      log_info "Removing old backup: ${old_backup}"
      rm -rf "${backup_dir}/${old_backup}"
    done
  fi
}

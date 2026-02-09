# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-02-09

### 🎉 Major Refactoring

Complete restructuring of the dotfiles repository from a flat structure to a professional, modular system.

### Breaking Changes

- **Structure Changed**: Files moved from root to organized directories (`git/`, `zsh/`, `scripts/`, `docs/`)
- **Modular Zsh Config**: Single 190-line `zshrc` split into 15+ module files
- **New Installer**: Replaced `entorno.sh` with robust `install.sh` script
- **Symlink Paths**: Updated paths in `.gitconfig` to point to new locations

### Added

#### 📁 Directory Structure
- `git/` - Git configuration files
- `zsh/` - Zsh configuration with modular loading
- `zsh/config/` - 15+ configuration modules
- `scripts/` - Installation utilities
- `docs/` - Comprehensive documentation
- `backups/` - Automatic backup storage (gitignored)
- `local/` - Local overrides (gitignored)

#### 🔧 Zsh Modules
- `00-init.zsh` - Oh-My-Zsh initialization
- `10-path.zsh` - PATH configuration for all tools
- `20-environment.zsh` - Environment variables
- `30-aliases-general.zsh` - 15+ general aliases
- `31-aliases-git.zsh` - 14 Git aliases
- `32-aliases-composer.zsh` - 6 Composer aliases
- `33-aliases-laravel.zsh` - 7 Laravel/PHP aliases
- `34-aliases-go.zsh` - Go language aliases
- `35-aliases-macos.zsh` - macOS specific aliases
- `40-functions-general.zsh` - Utility functions
- `41-functions-docker.zsh` - 8 Docker functions
- `42-functions-git.zsh` - Git utility functions
- `43-functions-php.zsh` - PHP testing functions
- `99-local.zsh` - Local overrides (not tracked)

#### 🛠️ Installation System
- `install.sh` - New robust installer with:
  - Automatic backups before changes
  - Dry-run mode (`-d` flag)
  - Verbose mode (`-v` flag)
  - Non-interactive mode (`-y` flag)
  - System requirements checking
  - OS detection (macOS/Linux)
  - Symlink verification
  - Rollback on failure
- `uninstall.sh` - Safe uninstallation with:
  - Restore from backup option (`-r`)
  - Keep backups option (`-k`)
  - Clean removal of symlinks
- `scripts/utils.sh` - Shared utility functions
- `scripts/backup.sh` - Backup management (keeps last 5)
- `scripts/symlink.sh` - Symlink creation helpers

#### 📚 Documentation
- `README.md` - Comprehensive main documentation
- `docs/INSTALL.md` - Detailed installation guide (~200 lines)
- `docs/ALIASES.md` - Complete alias reference (~300 lines)
- `docs/FUNCTIONS.md` - Function documentation (~250 lines)
- `docs/TROUBLESHOOTING.md` - Common issues and solutions (~150 lines)
- `CHANGELOG.md` - This file

#### 🔒 Safety Features
- Automatic backups with timestamps
- Backup cleanup (keep last 5)
- Error handling and rollback
- Dry-run mode to preview changes
- Verification after installation

#### ⚙️ Configuration
- Support for local overrides (`~/.zshrc.local`)
- Modular configuration (enable/disable modules)
- Easy to extend (add files to `zsh/config/`)

### Improved

#### 📝 Git Configuration
- Updated `.gitconfig` paths to use `~/.dotfiles/` prefix
- Better organized in dedicated `git/` directory
- Proper symlink references

#### 🎨 Code Organization
- Logical grouping by function/category
- Numeric prefixes for guaranteed load order
- Separation of concerns (aliases vs functions)
- Category-specific modules (git, docker, laravel, etc.)

#### 🚀 Performance
- Ability to profile individual modules
- Easy to disable unused modules
- Optimized loading order

#### 📖 Documentation
- Complete reference for all 40+ aliases
- Detailed function documentation with examples
- Installation guide with screenshots
- Troubleshooting guide
- Inline comments in all config files

#### 🎯 Maintainability
- Easy to find and edit specific configurations
- Clear file naming conventions
- Modular structure allows selective use
- Self-documenting code structure

### Changed

- `zshrc` → Split into `zsh/.zshrc` (loader) + 15 module files
- `gitconfig` → Moved to `git/.gitconfig` with updated paths
- `gitignore` → Moved to `git/.gitignore_global`
- `gitmessage.txt` → Moved to `git/.gitmessage.txt`
- `entorno.sh` → Replaced with `install.sh`
- `.gitignore` → Updated to exclude backups and local configs

### Fixed

- Proper error handling in installation
- Backup system to prevent data loss
- Symlink path issues
- Theme installation reliability
- Missing documentation

### Migration Guide

For users upgrading from v1.x:

1. **Backup current setup:**
   ```bash
   cp ~/.zshrc ~/.zshrc.v1.backup
   cp ~/.gitconfig ~/.gitconfig.v1.backup
   ```

2. **Pull latest changes:**
   ```bash
   cd ~/.dotfiles
   git pull origin master
   ```

3. **Run new installer:**
   ```bash
   ./install.sh
   ```
   The installer will:
   - Automatically backup existing files
   - Create new modular structure
   - Set up symlinks
   - Verify installation

4. **Test configuration:**
   ```bash
   source ~/.zshrc
   type nope  # Test git alias
   type dbuild  # Test docker function
   ```

5. **Rollback if needed:**
   ```bash
   ./uninstall.sh -r  # Restore from backup
   ```

## [1.x] - Legacy (Pre-2026)

### Structure
- Flat file structure
- Single `zshrc` file (190 lines)
- Basic `entorno.sh` installer
- Minimal documentation

### Features
- Oh-My-Zsh integration
- Honukai theme
- Git aliases and functions
- Docker functions
- Composer shortcuts
- Laravel/PHP utilities

---

## Future Plans

### [2.1.0] - Planned
- [ ] Automated tests for installation script
- [ ] Support for other shells (bash, fish)
- [ ] Interactive module selection during install
- [ ] Additional themes support
- [ ] Plugin system for extensions

### [2.2.0] - Planned
- [ ] Auto-update mechanism
- [ ] Cloud sync for local configs
- [ ] Better NVM lazy loading
- [ ] Completion functions
- [ ] Shell prompt customization options

---

**Note:** Version 2.0.0 is a complete rewrite focused on modularity, documentation, and maintainability while preserving all existing functionality.

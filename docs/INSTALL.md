# Installation Guide

Complete guide to installing and configuring your dotfiles.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Steps](#installation-steps)
- [What Gets Installed](#what-gets-installed)
- [Post-Installation](#post-installation)
- [Updating](#updating)
- [Uninstallation](#uninstallation)

## Prerequisites

### Required

Before installing, ensure you have:

1. **Zsh** - Should be pre-installed on macOS. On Linux:
   ```bash
   # Ubuntu/Debian
   sudo apt install zsh

   # Fedora
   sudo dnf install zsh

   # Make it your default shell
   chsh -s $(which zsh)
   ```

2. **Oh-My-Zsh** - Install first:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Git** - For version control:
   ```bash
   # macOS (if not present)
   xcode-select --install

   # Ubuntu/Debian
   sudo apt install git
   ```

4. **curl** - For downloading files:
   ```bash
   # Should be pre-installed, verify with:
   which curl
   ```

### Optional (for full functionality)

- **Docker Desktop** - For Docker functions
- **Composer** - For PHP development: `brew install composer`
- **NVM** - For Node.js: [NVM Installation](https://github.com/nvm-sh/nvm)
- **Go** - For Go development: [Go Installation](https://golang.org/doc/install)
- **Flutter** - For Flutter development: [Flutter Installation](https://flutter.dev/docs/get-started/install)

## Installation Steps

### 1. Clone the Repository

```bash
# Clone to ~/.dotfiles (recommended location)
git clone https://github.com/abr4xas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Preview Installation (Optional)

Run in dry-run mode to see what will happen:

```bash
./install.sh -d
```

This shows:
- Which files will be backed up
- Where symlinks will be created
- What will be downloaded

### 3. Run the Installer

```bash
# Interactive installation (recommended for first time)
./install.sh

# Non-interactive (auto-confirm)
./install.sh -y

# Verbose output
./install.sh -v
```

### 4. Reload Your Shell

```bash
source ~/.zshrc
```

Or restart your terminal application.

## What Gets Installed

### File Operations

The installer performs these actions:

1. **Backs up existing files** to `backups/TIMESTAMP/`:
   - `~/.zshrc`
   - `~/.gitconfig`
   - `~/.gitignore`
   - `~/.gitmessage.txt`

2. **Creates symlinks**:
   ```
   ~/.zshrc           -> ~/.dotfiles/zsh/.zshrc
   ~/.gitconfig       -> ~/.dotfiles/git/.gitconfig
   ~/.gitignore       -> ~/.dotfiles/git/.gitignore_global
   ~/.gitmessage.txt  -> ~/.dotfiles/git/.gitmessage.txt
   ```

3. **Downloads theme**:
   - Honukai theme to `~/.oh-my-zsh/themes/honukai.zsh-theme`

### Configuration Loaded

The new `.zshrc` loads modules in this order:

1. `00-init.zsh` - Oh-My-Zsh initialization
2. `10-path.zsh` - PATH configuration
3. `20-environment.zsh` - Environment variables
4. `30-aliases-general.zsh` - General aliases
5. `31-aliases-git.zsh` - Git aliases
6. `32-aliases-composer.zsh` - Composer aliases
7. `33-aliases-laravel.zsh` - Laravel aliases
8. `34-aliases-go.zsh` - Go aliases
9. `35-aliases-macos.zsh` - macOS specific aliases
10. `40-functions-general.zsh` - General functions
11. `41-functions-docker.zsh` - Docker functions
12. `42-functions-git.zsh` - Git functions
13. `43-functions-php.zsh` - PHP testing functions
14. `99-local.zsh` - Local overrides

## Post-Installation

### Verify Installation

Check that everything loaded correctly:

```bash
# Check if modules are loaded
type nope         # Should show git alias
type dbuild       # Should show docker function
type p            # Should show PHP test function

# Check paths
echo $PATH | grep composer
echo $GOPATH
which nvm
```

### Test Functionality

Try some commands:

```bash
# Navigation
..              # Go up one directory
l               # List files with details

# Git (in a git repo)
gl              # Beautiful git log
git status      # Should show branch info

# Docker (if Docker is installed)
type dbuild     # Should show the function definition
```

### Configure Git User

Update your git user information:

```bash
# Edit the git config
nano ~/.dotfiles/git/.gitconfig

# Or use git commands
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Add Local Customizations

Create a local config file for machine-specific settings:

```bash
# Create local zsh config
touch ~/.zshrc.local

# Add your customizations
echo 'alias myproject="cd ~/code/my-project"' >> ~/.zshrc.local
echo 'export API_KEY="secret"' >> ~/.zshrc.local

# Reload
source ~/.zshrc
```

## Updating

### Pull Latest Changes

```bash
cd ~/.dotfiles
git pull origin master
source ~/.zshrc
```

The symlinks ensure changes take effect immediately.

### Update Oh-My-Zsh

```bash
omz update
```

### Reinstall (with backup)

```bash
cd ~/.dotfiles
./install.sh -y
```

This creates a new backup and re-creates symlinks.

## Uninstallation

### Option 1: Remove and Restore

Remove dotfiles and restore from backup:

```bash
cd ~/.dotfiles
./uninstall.sh -r
```

This will:
- Remove all symlinks
- Restore original files from most recent backup
- Keep backup directory

### Option 2: Remove Only

Remove symlinks but keep backups:

```bash
./uninstall.sh -k
```

### Option 3: Complete Removal

Remove everything including backups:

```bash
./uninstall.sh
# When prompted, confirm removal of backups
```

### Manual Cleanup

If scripts fail, manually remove:

```bash
# Remove symlinks
rm ~/.zshrc ~/.gitconfig ~/.gitignore ~/.gitmessage.txt

# Remove theme
rm ~/.oh-my-zsh/themes/honukai.zsh-theme

# Restore from backup manually
cp ~/.dotfiles/backups/LATEST_TIMESTAMP/.zshrc ~/
cp ~/.dotfiles/backups/LATEST_TIMESTAMP/.gitconfig ~/
# etc...

# Remove dotfiles directory
rm -rf ~/.dotfiles
```

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues and solutions.

## Next Steps

- Read [ALIASES.md](ALIASES.md) for a complete reference of all aliases
- Read [FUNCTIONS.md](FUNCTIONS.md) for documentation on utility functions
- Customize `~/.zshrc.local` for your machine-specific needs
- Explore and disable modules you don't need

---

Need help? [Open an issue](https://github.com/abr4xas/dotfiles/issues) on GitHub.

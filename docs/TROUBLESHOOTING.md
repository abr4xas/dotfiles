# Troubleshooting Guide

Solutions to common issues you might encounter with the dotfiles.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Oh-My-Zsh Issues](#oh-my-zsh-issues)
- [Theme Issues](#theme-issues)
- [Symlink Issues](#symlink-issues)
- [PATH Issues](#path-issues)
- [Performance Issues](#performance-issues)
- [Docker Function Issues](#docker-function-issues)
- [Git Configuration Issues](#git-configuration-issues)
- [Restore and Recovery](#restore-and-recovery)

## Installation Issues

### "Oh-My-Zsh not found"

**Problem:** Installer reports Oh-My-Zsh is not installed

**Solution:**
```bash
# Install Oh-My-Zsh first
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Then run dotfiles installer
cd ~/.dotfiles
./install.sh
```

**Verify Installation:**
```bash
ls -la ~/.oh-my-zsh
# Should show Oh-My-Zsh directory
```

---

### "Permission denied" during installation

**Problem:** Cannot create symlinks or write files

**Solution 1:** Check file permissions
```bash
ls -la ~/ | grep zshrc
# Fix permissions if needed
chmod 644 ~/.zshrc
```

**Solution 2:** Not running as root (good!)
```bash
# DON'T run as root
# Run as regular user:
./install.sh
```

**Solution 3:** Home directory permissions
```bash
ls -la ~/ | head -n 1
# Should show your username as owner
```

---

### Installation script fails midway

**Problem:** Script exits with error

**Solution:**
```bash
# Check what failed
./install.sh -v  # Verbose mode

# Restore from backup if needed
./uninstall.sh -r

# Try again
./install.sh
```

**Debug Mode:**
```bash
# Run with bash debug mode
bash -x ./install.sh
```

---

## Oh-My-Zsh Issues

### Oh-My-Zsh update prompts

**Problem:** Constant update prompts

**Solution:**
```bash
# Update Oh-My-Zsh
omz update

# Or disable auto-update
echo 'DISABLE_AUTO_UPDATE="true"' >> ~/.zshrc.local
source ~/.zshrc
```

---

### Plugin not loading

**Problem:** Oh-My-Zsh plugin doesn't work

**Solution:**
```bash
# Edit 00-init.zsh
nano ~/.dotfiles/zsh/config/00-init.zsh

# Add plugin to array
plugins=(git docker npm)  # Add your plugin

# Reload
source ~/.zshrc
```

**Check Plugin Exists:**
```bash
ls ~/.oh-my-zsh/plugins/
```

---

## Theme Issues

### Theme not loading / plain prompt

**Problem:** Terminal doesn't show Honukai theme

**Solution 1:** Check theme file
```bash
ls -la ~/.oh-my-zsh/themes/honukai.zsh-theme
# Should exist

# Re-download if missing
curl -fsSL https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm-zsh/master/honukai.zsh-theme -o ~/.oh-my-zsh/themes/honukai.zsh-theme
```

**Solution 2:** Verify theme setting
```bash
# Check config
cat ~/.dotfiles/zsh/config/00-init.zsh | grep ZSH_THEME
# Should show: ZSH_THEME=honukai

# Reload
source ~/.zshrc
```

**Solution 3:** Font issues
- Install a Powerline font for proper icons
- Try [Nerd Fonts](https://www.nerdfonts.com/)

---

### Colors not showing correctly

**Problem:** Terminal colors are wrong or missing

**Solution:**
```bash
# Enable terminal color support
export TERM=xterm-256color

# Test colors
curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
```

**macOS Terminal:** Preferences → Profiles → Advanced → Declare terminal as: `xterm-256color`

**iTerm2:** Should work by default

---

## Symlink Issues

### Symlinks broken after moving dotfiles

**Problem:** Symlinks point to wrong location

**Solution:**
```bash
# Remove broken symlinks
rm ~/.zshrc ~/.gitconfig ~/.gitignore ~/.gitmessage.txt

# Re-run installer
cd ~/.dotfiles  # Make sure you're in the right place
./install.sh
```

---

### Cannot remove existing file

**Problem:** "File exists and is not a symlink"

**Solution:**
```bash
# Backup manually
cp ~/.zshrc ~/.zshrc.backup

# Remove
rm ~/.zshrc

# Re-create symlink
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

---

### Symlink verification fails

**Problem:** Installer says symlink verification failed

**Solution:**
```bash
# Check symlinks manually
ls -la ~/.zshrc ~/.gitconfig ~/.gitignore ~/.gitmessage.txt

# Should show -> pointing to ~/.dotfiles/...

# Fix manually
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/.gitignore_global ~/.gitignore
ln -sf ~/.dotfiles/git/.gitmessage.txt ~/.gitmessage.txt
```

---

## PATH Issues

### Command not found after installation

**Problem:** `nvm`, `composer`, or `go` commands not found

**Solution 1:** Check PATH
```bash
echo $PATH
# Should include:
# - /usr/local/bin
# - $HOME/.composer/vendor/bin
# - $HOME/go/bin
# - $HOME/.nvm
```

**Solution 2:** Verify PATH module loaded
```bash
# Check if module is loaded
cat ~/.dotfiles/zsh/config/10-path.zsh

# Reload
source ~/.zshrc
```

**Solution 3:** Install missing tools
```bash
# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Composer
brew install composer

# Go
brew install go
```

---

### NVM not loading

**Problem:** `nvm` command not found

**Solution:**
```bash
# Check NVM directory
ls -la ~/.nvm
# Should exist

# Install NVM if missing
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload
source ~/.zshrc

# Verify
nvm --version
```

---

## Performance Issues

### Slow shell startup

**Problem:** Terminal takes several seconds to open

**Solution 1:** Profile zsh startup
```bash
# Add to top of ~/.zshrc
zmodload zsh/zprof

# Add to bottom of ~/.zshrc
zprof

# Open new terminal to see report
```

**Solution 2:** Disable slow plugins
```bash
# Edit 00-init.zsh
nano ~/.dotfiles/zsh/config/00-init.zsh

# Reduce plugins
plugins=(git)  # Minimal set

# Reload
source ~/.zshrc
```

**Solution 3:** Optimize NVM loading
```bash
# Edit 10-path.zsh
nano ~/.dotfiles/zsh/config/10-path.zsh

# Add lazy loading
# Comment out: [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# Add: alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm"
```

---

### Commands are slow

**Problem:** Git or other commands take long time

**Solution:**
```bash
# Check for slow completions
rm ~/.zcompdump*
source ~/.zshrc

# Rebuild completion cache
compinit
```

---

## Docker Function Issues

### Docker commands not working

**Problem:** `dbuild`, `dstart` etc. fail

**Solution 1:** Check Docker is running
```bash
docker ps
# Should show running containers or empty list

# If error, start Docker Desktop
```

**Solution 2:** Check docker-compose.yml exists
```bash
ls docker-compose.yml
# Should exist in current directory

cd /path/to/project
dbuild
```

**Solution 3:** Verify function loaded
```bash
type dbuild
# Should show function definition

# Reload if needed
source ~/.zshrc
```

---

### ddall() fails with errors

**Problem:** Cannot remove all containers

**Solution:**
```bash
# Stop containers first
docker stop $(docker ps -aq)

# Remove containers
docker rm $(docker ps -aq)

# Remove images (if you want)
docker rmi $(docker images -q)

# Clean system
docker system prune -a
```

---

## Git Configuration Issues

### Git user not set

**Problem:** "Please tell me who you are" error

**Solution:**
```bash
# Edit git config
nano ~/.dotfiles/git/.gitconfig

# Update user section:
[user]
  name = Your Name
  email = your.email@example.com

# Or use git commands
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

### Commit template not loading

**Problem:** Git doesn't use custom commit template

**Solution:**
```bash
# Check config
git config --global commit.template
# Should show: ~/.dotfiles/git/.gitmessage.txt

# Fix if needed
git config --global commit.template ~/.dotfiles/git/.gitmessage.txt
```

---

### Global gitignore not working

**Problem:** Files still showing up that should be ignored

**Solution:**
```bash
# Check config
git config --global core.excludesfile
# Should show: ~/.dotfiles/git/.gitignore_global

# Fix if needed
git config --global core.excludesfile ~/.dotfiles/git/.gitignore_global

# Test
echo "test" > .DS_Store
git status  # Should not show .DS_Store
```

---

## Restore and Recovery

### Restore from backup

**Problem:** Need to undo installation

**Solution:**
```bash
# Automatic restore
./uninstall.sh -r

# Manual restore
ls ~/.dotfiles/backups/
# Find latest backup (timestamp directory)

cd ~/.dotfiles/backups/TIMESTAMP
cp .zshrc ~/
cp .gitconfig ~/
cp .gitignore ~/
cp .gitmessage.txt ~/

source ~/.zshrc
```

---

### Complete reset

**Problem:** Want to start completely fresh

**Solution:**
```bash
# Uninstall
cd ~/.dotfiles
./uninstall.sh

# Remove dotfiles
rm -rf ~/.dotfiles

# Remove Oh-My-Zsh
rm -rf ~/.oh-my-zsh

# Reinstall everything
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/abr4xas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

---

### Check what's loaded

**Problem:** Want to verify configuration

**Solution:**
```bash
# List all aliases
alias

# List all functions
functions

# Check loaded modules
ls ~/.dotfiles/zsh/config/*.zsh

# Test specific alias/function
type nope
type dbuild
type p
```

---

## Debug Commands

### Useful debugging commands

```bash
# Reload configuration
source ~/.zshrc

# Check zsh version
zsh --version

# Check Oh-My-Zsh
echo $ZSH

# List all environment variables
env

# Check shell
echo $SHELL

# Verify symlinks
ls -la ~ | grep "\->"

# Test module loading
for config in ~/.dotfiles/zsh/config/*.zsh; do
  echo "Loading: $config"
  source "$config"
done
```

---

## Getting More Help

### Still having issues?

1. **Check logs:**
   ```bash
   # Run installer in verbose mode
   ./install.sh -v
   ```

2. **Dry run:**
   ```bash
   # See what would happen
   ./install.sh -d
   ```

3. **GitHub Issues:**
   - Check existing: https://github.com/abr4xas/dotfiles/issues
   - Create new issue with:
     - Error message
     - Steps to reproduce
     - System info: `uname -a`
     - Zsh version: `zsh --version`

4. **Manual verification:**
   ```bash
   # Verify all files
   ls -la ~/.dotfiles/zsh/.zshrc
   ls -la ~/.dotfiles/git/.gitconfig
   ls -la ~/.oh-my-zsh/themes/honukai.zsh-theme
   ```

---

## Prevention Tips

- ✅ Always backup before major changes
- ✅ Test in dry-run mode first: `./install.sh -d`
- ✅ Keep backups: Don't remove `backups/` directory
- ✅ Use `~/.zshrc.local` for experiments
- ✅ Commit changes before updates: `cd ~/.dotfiles && git status`

---

**Remember:** Backups are automatically created in `~/.dotfiles/backups/` during installation!

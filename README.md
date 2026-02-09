# Dotfiles

> Professional, modular dotfiles for macOS/Linux development with PHP, Laravel, Node, Go, Flutter, and Docker.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Features

- 🚀 **Modular Configuration** - 15+ organized config files instead of one monolithic file
- 🎨 **Beautiful Terminal** - Honukai theme with Oh-My-Zsh integration
- 🐘 **PHP/Laravel Optimized** - Composer, Artisan, Pest/PHPUnit shortcuts
- 🐳 **Docker Integration** - 8+ Docker utility functions for common workflows
- 📝 **Smart Git Aliases** - 14+ aliases including `wip`, `nope`, `yolo`, and more
- 🔧 **Safe Installation** - Automatic backups, rollback support, and dry-run mode
- 📚 **Comprehensive Docs** - Complete reference for all 40+ aliases and functions
- 🌐 **Multi-Language Support** - Go, Node (NVM), PHP, Flutter paths configured
- 🍎 **macOS Optimized** - Finder tweaks, screen lock, and app shortcuts

## Quick Start

### Prerequisites

- macOS or Linux
- [Oh-My-Zsh](https://ohmyz.sh/) installed
- Git, curl, and zsh

### Installation

```bash
# Clone the repository
git clone https://github.com/abr4xas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installer (with automatic backups)
./install.sh

# Or run in dry-run mode to preview changes
./install.sh -d

# Reload your shell
source ~/.zshrc
```

The installer will:
- ✅ Check system requirements
- ✅ Backup existing dotfiles
- ✅ Create symlinks to config files
- ✅ Install Honukai theme
- ✅ Verify installation

### Uninstallation

```bash
# Remove symlinks and restore from backup
./uninstall.sh -r

# Remove symlinks only (keep backups)
./uninstall.sh -k
```

## What's Included

### Directory Structure

```
dotfiles/
├── git/              # Git configuration
│   ├── .gitconfig
│   ├── .gitignore_global
│   └── .gitmessage.txt
├── zsh/              # Zsh configuration
│   ├── .zshrc        # Main loader
│   └── config/       # 15 modular config files
│       ├── 00-init.zsh
│       ├── 10-path.zsh
│       ├── 20-environment.zsh
│       ├── 30-aliases-general.zsh
│       ├── 31-aliases-git.zsh
│       ├── 32-aliases-composer.zsh
│       ├── 33-aliases-laravel.zsh
│       ├── 34-aliases-go.zsh
│       ├── 35-aliases-macos.zsh
│       ├── 40-functions-general.zsh
│       ├── 41-functions-docker.zsh
│       ├── 42-functions-git.zsh
│       ├── 43-functions-php.zsh
│       └── 99-local.zsh (your customizations)
├── scripts/          # Installation utilities
├── docs/             # Comprehensive documentation
└── backups/          # Automatic backups (gitignored)
```

### Highlighted Features

#### Git Aliases
```bash
nope        # Reset everything (git reset --hard && git clean)
wip         # Quick commit with bug emoji
yolo        # Commit with random message from whatthecommit.com
gl          # Beautiful git log with graph
```

#### Docker Functions
```bash
dbuild      # docker-compose build
dstart      # docker-compose up -d
dexec bash  # docker-compose exec bash
ddall       # Remove all containers, images, volumes
kdo         # Kill Docker Desktop
```

#### Laravel/PHP
```bash
art         # php artisan
tinker      # php artisan tinker
mfs         # migrate:fresh --seed
p           # Run Pest or PHPUnit
pf filter   # Run tests with filter
```

#### Composer
```bash
climb       # List outdated packages
ci          # composer install
cu          # composer update
cgu         # Update global composer
```

## Documentation

- 📖 [Installation Guide](docs/INSTALL.md) - Detailed setup instructions
- 📋 [Aliases Reference](docs/ALIASES.md) - All 40+ aliases documented
- ⚡ [Functions Reference](docs/FUNCTIONS.md) - Utility functions explained
- 🔧 [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues and solutions

## Customization

### Local Overrides

Create `~/.zshrc.local` for machine-specific configuration:

```bash
# Example local overrides
alias myproject="cd ~/code/secret-project"
export API_KEY="your-secret-key"
```

This file is automatically loaded but not tracked in git.

### Disabling Modules

To disable a module, rename it to remove the `.zsh` extension:

```bash
cd ~/.dotfiles/zsh/config
mv 35-aliases-macos.zsh 35-aliases-macos.zsh.disabled
source ~/.zshrc
```

### Adding New Modules

Create a new file in `zsh/config/` with a numeric prefix:

```bash
echo "alias myalias='echo hello'" > ~/.dotfiles/zsh/config/50-my-custom.zsh
source ~/.zshrc
```

## Requirements

- **Zsh** - Modern shell
- **Oh-My-Zsh** - Framework for Zsh configuration
- **Git** - Version control
- **curl** - For downloading theme and whatthecommit

### Optional
- **Docker** - For Docker functions
- **Composer** - For PHP/Laravel aliases
- **NVM** - For Node version management
- **Go** - For Go development
- **Flutter** - For Flutter development

## Migration from v1.x

If you're using the old flat structure:

1. Your existing dotfiles will be backed up automatically
2. Run `./install.sh` to migrate to the new structure
3. Test the new configuration
4. Keep the backup or run `./uninstall.sh -r` to rollback

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Author

**Angel Cruz** ([@abr4xas](https://github.com/abr4xas))
- Website: [angelcruz.dev](https://angelcruz.dev)

## Acknowledgments

- [Oh-My-Zsh](https://ohmyz.sh/) - Zsh framework
- [Honukai Theme](https://github.com/oskarkrawczyk/honukai-iterm-zsh) - Terminal theme
- [What The Commit](https://whatthecommit.com/) - Random commit messages

---

⭐ If you find this useful, please star the repo!

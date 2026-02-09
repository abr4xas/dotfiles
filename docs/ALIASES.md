# Aliases Reference

Complete reference for all aliases included in the dotfiles.

## Table of Contents

- [General Aliases](#general-aliases)
- [Git Aliases](#git-aliases)
- [Composer Aliases](#composer-aliases)
- [Laravel/PHP Aliases](#laravelphp-aliases)
- [Go Aliases](#go-aliases)
- [macOS Aliases](#macos-aliases)

## General Aliases

Located in: `zsh/config/30-aliases-general.zsh`

### Shell Management

#### `reloadcli`
**Command:** `source $HOME/.zshrc`
**Description:** Reload the zsh configuration without restarting terminal
**Example:**
```bash
reloadcli  # Reload after making changes to config
```

### Navigation

#### `..`
**Command:** `cd ../`
**Description:** Go up one directory level
**Example:**
```bash
..  # Move to parent directory
```

#### `...`
**Command:** `cd ../../`
**Description:** Go up two directory levels
**Example:**
```bash
...  # Move two directories up
```

#### `....`
**Command:** `cd ../../../`
**Description:** Go up three directory levels

#### `.....`
**Command:** `cd ../../../../`
**Description:** Go up four directory levels

#### `home`
**Command:** `cd ~`
**Description:** Navigate to home directory
**Example:**
```bash
home  # Jump to home directory from anywhere
```

### File Management

#### `l`
**Command:** `ls -laF`
**Description:** List all files with details including hidden files
**Example:**
```bash
l  # Show detailed file listing
```
**Output:**
```
total 48
drwxr-xr-x  12 user  staff   384 Feb  9 10:00 .
drwxr-xr-x   8 user  staff   256 Feb  9 09:00 ..
-rw-r--r--   1 user  staff  1234 Feb  9 10:00 README.md
```

#### `c`
**Command:** `clear`
**Description:** Clear the terminal screen
**Example:**
```bash
c  # Clear screen
```

### System Configuration

#### `hostfile`
**Command:** `sudo nano /etc/hosts`
**Description:** Edit the hosts file with sudo privileges
**Example:**
```bash
hostfile  # Opens hosts file for editing
```
**Use Case:** Add local domain mappings like `127.0.0.1 myproject.local`

#### `reloaddns`
**Command:** `dscacheutil -flushcache && sudo killall -HUP mDNSResponder`
**Description:** Flush DNS cache on macOS
**Example:**
```bash
reloaddns  # Clear DNS cache after hosts file changes
```

### Development

#### `phpserver`
**Command:** `php -S localhost:8888`
**Description:** Start PHP built-in development server on port 8888
**Example:**
```bash
phpserver  # Start server in current directory
# Visit: http://localhost:8888
```

### Utilities

#### `publickey`
**Command:** `pbcopy < ~/.ssh/id_rsa.pub`
**Description:** Copy your SSH public key to clipboard
**Example:**
```bash
publickey  # Copy SSH key for GitHub, GitLab, etc.
```

#### `_`
**Command:** `sudo `
**Description:** Shorthand for sudo (preserves aliases)
**Example:**
```bash
_ apt update  # Run apt update with sudo
```

#### `shrug`
**Command:** `echo '¯\_(ツ)_/¯' | pbcopy`
**Description:** Copy shrug emoji to clipboard
**Example:**
```bash
shrug  # Copy ¯\_(ツ)_/¯ to use in messages
```

#### `brewall`
**Command:** `brew update && brew upgrade && brew cleanup`
**Description:** Update Homebrew, upgrade packages, and cleanup
**Example:**
```bash
brewall  # Complete Homebrew maintenance
```

## Git Aliases

Located in: `zsh/config/31-aliases-git.zsh`

### Reset and Clean

#### `nope`
**Command:** `git reset --hard; git clean -df`
**Description:** Nuclear option - discard all changes and untracked files
**Example:**
```bash
nope  # Undo everything, start fresh (⚠️ DESTRUCTIVE)
```
**Warning:** This permanently deletes uncommitted changes!

#### `gclean`
**Command:** `git clean -df`
**Description:** Remove all untracked files and directories
**Example:**
```bash
gclean  # Delete untracked files
```

### Push/Pull Operations

#### `pushlive`
**Command:** `git push origin master && git push live master`
**Description:** Push to both origin and live remotes
**Example:**
```bash
pushlive  # Deploy to production
```

#### `pushmaster`
**Command:** `git push origin master`
**Description:** Push current commits to origin master
**Example:**
```bash
pushmaster  # Push to master branch
```

#### `pom`
**Command:** `git pull origin master`
**Description:** Pull latest changes from origin master
**Example:**
```bash
pom  # Update local master branch
```

### Quick Commits

#### `wip`
**Command:** `git add . && git commit -m ' Fixed what needed fixing and squished some bugs. :bug:'`
**Description:** Quick commit for work in progress
**Example:**
```bash
wip  # Save current state with bug emoji
```

#### `yolo`
**Command:** `git add . && git commit -m "$(whatthecommit)"`
**Description:** Commit with random message from whatthecommit.com
**Example:**
```bash
yolo  # Commit with funny random message
```
**Example messages:** "Does anyone even read these anymore?", "It works on my machine"

#### `donetoday`
**Command:** `git add . && git commit -m 'To be honest, I do not quite remember everyting I changed here today ¯\_(ツ)_/¯ But it is all good, I tell ya.'`
**Description:** End-of-day commit with honest message
**Example:**
```bash
donetoday  # Commit everything at end of day
```

### Commit Management

#### `undocommit`
**Command:** `git reset HEAD~1`
**Description:** Undo last commit but keep changes staged
**Example:**
```bash
undocommit  # Undo last commit, fix, and re-commit
```

#### `fix`
**Command:** `git diff --name-only | uniq | xargs code`
**Description:** Open all changed files in VS Code
**Example:**
```bash
fix  # Open all modified files to fix them
```

### Logging

#### `gl`
**Command:** `git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit`
**Description:** Beautiful, colorful git log with graph
**Example:**
```bash
gl  # View commit history
```
**Output:**
```
* a1b2c3d - (HEAD -> master) Add new feature (2 hours ago) <Angel>
* d4e5f6g - Fix bug in authentication (1 day ago) <Angel>
```

## Composer Aliases

Located in: `zsh/config/32-aliases-composer.zsh`

#### `climb`
**Command:** `composer outdated --outdated --direct`
**Description:** List outdated direct dependencies
**Example:**
```bash
climb  # Check which packages need updating
```
**Reference:** [Original blog post](https://jenssegers.com/83/list-outdated-composer-packages)

#### `cdo`
**Command:** `composer dump-autoload -o`
**Description:** Regenerate optimized autoload files
**Example:**
```bash
cdo  # Rebuild autoload after adding new classes
```

#### `ci`
**Command:** `composer install`
**Description:** Install dependencies from composer.lock
**Example:**
```bash
ci  # Install project dependencies
```

#### `cu`
**Command:** `composer update`
**Description:** Update dependencies to latest versions
**Example:**
```bash
cu  # Update all packages
```

#### `cgu`
**Command:** `cd ~/.composer && composer update`
**Description:** Update global composer packages
**Example:**
```bash
cgu  # Update global tools
```

#### `update-global-composer`
**Command:** `cd ~/.composer && composer update`
**Description:** Same as `cgu` (alternative name)
**Example:**
```bash
update-global-composer  # Update global tools
```

## Laravel/PHP Aliases

Located in: `zsh/config/33-aliases-laravel.zsh`

### Artisan

#### `art`
**Command:** `php artisan`
**Description:** Laravel Artisan CLI shortcut
**Example:**
```bash
art make:controller UserController  # Create controller
art migrate                          # Run migrations
```

#### `tinker`
**Command:** `php artisan tinker`
**Description:** Open Laravel REPL for testing
**Example:**
```bash
tinker  # Interactive shell to test code
>>> User::count()
=> 42
```

#### `routelist`
**Command:** `php artisan route:list`
**Description:** Display all registered routes
**Example:**
```bash
routelist  # Show all application routes
```

#### `mfs`
**Command:** `php artisan migrate:fresh --seed`
**Description:** Drop all tables, re-run migrations, and seed database
**Example:**
```bash
mfs  # Reset database to fresh state
```
**Warning:** Deletes all data!

### Laravel Tools

#### `sail`
**Command:** `bash vendor/bin/sail`
**Description:** Laravel Sail (Docker) command shortcut
**Example:**
```bash
sail up          # Start Docker containers
sail artisan     # Run artisan in container
sail composer    # Run composer in container
```

#### `envoy`
**Command:** `php vendor/bin/envoy`
**Description:** Laravel Envoy task runner
**Example:**
```bash
envoy run deploy  # Run deployment task
```

#### `pint`
**Command:** `composer format`
**Description:** Run Laravel Pint code formatter
**Example:**
```bash
pint  # Format code according to Laravel standards
```

## Go Aliases

Located in: `zsh/config/34-aliases-go.zsh`

#### `gr`
**Command:** `go run`
**Description:** Compile and run Go program
**Example:**
```bash
gr main.go  # Run Go application
```

## macOS Aliases

Located in: `zsh/config/35-aliases-macos.zsh`

### Applications

#### `storm`
**Command:** `open -a /Applications/PhpStorm.app \`pwd\``
**Description:** Open current directory in PhpStorm
**Example:**
```bash
cd ~/code/my-project
storm  # Open project in PhpStorm
```

### Finder

#### `show`
**Command:** `defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder`
**Description:** Show hidden files in Finder
**Example:**
```bash
show  # Make .env, .git, etc. visible in Finder
```

#### `hide`
**Command:** `defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder`
**Description:** Hide hidden files in Finder
**Example:**
```bash
hide  # Hide dot files again
```

### System

#### `afk`
**Command:** `osascript -e 'tell application "System Events" to keystroke "q" using {command down,control down}'`
**Description:** Lock the screen immediately
**Example:**
```bash
afk  # Lock screen before leaving computer
```

## Quick Reference Table

### Most Used Aliases

| Alias | Command | Category |
|-------|---------|----------|
| `nope` | git reset --hard | Git |
| `wip` | Quick commit | Git |
| `art` | php artisan | Laravel |
| `tinker` | artisan tinker | Laravel |
| `p` | Run tests | PHP |
| `..` | cd ../ | Navigation |
| `l` | ls -laF | Files |
| `ci` | composer install | Composer |
| `mfs` | migrate:fresh --seed | Laravel |
| `gl` | Pretty git log | Git |

## See Also

- [Functions Reference](FUNCTIONS.md) - Utility functions
- [Installation Guide](INSTALL.md) - Setup instructions
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues

---

**Tip:** Type `alias` in terminal to see all defined aliases.

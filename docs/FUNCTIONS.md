# Functions Reference

Complete documentation for all shell functions included in the dotfiles.

## Table of Contents

- [General Functions](#general-functions)
- [Docker Functions](#docker-functions)
- [Git Functions](#git-functions)
- [PHP Testing Functions](#php-testing-functions)

## General Functions

Located in: `zsh/config/40-functions-general.zsh`

### create()

**Purpose:** Create a directory and immediately change into it

**Syntax:**
```bash
create <directory_name>
```

**Parameters:**
- `directory_name` - Name of the directory to create

**Examples:**
```bash
create myproject       # Creates and enters 'myproject' directory
create test/subfolder  # Creates nested directories and enters
```

**Use Cases:**
- Quick project setup
- Creating test directories
- Organizing files on the fly

**Related:**
- Combine with other commands: `create temp && touch README.md`

---

### extract()

**Purpose:** Extract various archive formats automatically

**Syntax:**
```bash
extract <archive_file>
```

**Parameters:**
- `archive_file` - Path to archive file

**Supported Formats:**
- `.tar.bz2` - Bzip2 compressed tar
- `.tar.gz`, `.tgz` - Gzip compressed tar
- `.tar` - Uncompressed tar
- `.bz2` - Bzip2 compressed
- `.gz` - Gzip compressed
- `.zip` - ZIP archive
- `.rar` - RAR archive
- `.7z` - 7-Zip archive
- `.Z` - Compress format

**Examples:**
```bash
extract archive.tar.gz     # Extracts tar.gz file
extract package.zip        # Extracts zip file
extract backup.tar.bz2     # Extracts tar.bz2 file
```

**Error Handling:**
- Shows error if file doesn't exist
- Shows error if format is not supported

**Use Cases:**
- Extracting downloads
- Unpacking backups
- Working with compressed packages

**Requirements:**
- `tar` - For tar archives
- `unzip` - For ZIP files
- `unrar` - For RAR files
- `7z` - For 7z files

---

### whatthecommit()

**Purpose:** Fetch a random commit message from whatthecommit.com

**Syntax:**
```bash
whatthecommit
```

**Parameters:** None

**Examples:**
```bash
whatthecommit
# Output: "Does anyone even read these anymore?"

# Use with yolo alias
yolo  # Commits with random message
```

**Example Messages:**
- "It works on my machine"
- "Fixed a bug I introduced yesterday"
- "Don't ask me why this works"
- "TODO: write meaningful commit message"

**Use Cases:**
- Fun commit messages for personal projects
- Used by the `yolo` alias
- Quick commits for experimental branches

**Requirements:**
- Internet connection
- `curl` command

**Related:**
- `yolo` alias - Uses this function
- [whatthecommit.com](https://whatthecommit.com/)

---

## Docker Functions

Located in: `zsh/config/41-functions-docker.zsh`

### dbuild()

**Purpose:** Build Docker Compose services

**Syntax:**
```bash
dbuild
```

**Parameters:** None

**Examples:**
```bash
dbuild  # Builds all services in docker-compose.yml
```

**Full Command:** `docker-compose build`

**Use Cases:**
- Rebuild images after Dockerfile changes
- Initial project setup
- Updating dependencies in containers

**Related:**
- `dstart()` - Start containers after building
- Combine: `dbuild && dstart`

---

### dstart()

**Purpose:** Start Docker Compose services in detached mode

**Syntax:**
```bash
dstart
```

**Parameters:** None

**Examples:**
```bash
dstart  # Starts all services in background
```

**Full Command:** `docker-compose up -d`

**Use Cases:**
- Starting development environment
- Running background services
- After running `dbuild()`

**Verify:** Check with `docker ps`

**Related:**
- `dstop()` - Stop all services
- `dexec()` - Execute commands in running containers

---

### dexec()

**Purpose:** Execute bash in a Docker Compose service

**Syntax:**
```bash
dexec <service_name>
```

**Parameters:**
- `service_name` - Name of the service from docker-compose.yml

**Examples:**
```bash
dexec app        # Open bash in 'app' service
dexec php        # Open bash in 'php' service
dexec mysql      # Open bash in MySQL container
```

**Full Command:** `docker-compose exec <service> bash`

**Use Cases:**
- Running commands inside containers
- Debugging container issues
- Installing packages
- Checking logs inside containers

**Common Service Names:**
- `app` - Application container
- `php` - PHP-FPM container
- `nginx` - Web server
- `mysql` - Database
- `redis` - Cache

**Exit:** Type `exit` or press `Ctrl+D`

---

### dstop()

**Purpose:** Stop all Docker Compose services

**Syntax:**
```bash
dstop
```

**Parameters:** None

**Examples:**
```bash
dstop  # Stops all running services
```

**Full Command:** `docker-compose stop`

**Use Cases:**
- End of work day
- Free up system resources
- Before system maintenance

**Note:** Containers can be restarted with `dstart()`

**Related:**
- `dstart()` - Start containers
- `ddall()` - Complete cleanup

---

### mysqlIp()

**Purpose:** Get IP address of MySQL container

**Syntax:**
```bash
mysqlIp <container_name>
```

**Parameters:**
- `container_name` - Name of the container

**Examples:**
```bash
mysqlIp myapp_php_1  # Get MySQL IP from php container
```

**Full Command:** `docker exec <container> ping mysql`

**Use Cases:**
- Debugging database connections
- Network troubleshooting
- Configuring database clients

---

### mariaIp()

**Purpose:** Get IP address of MariaDB container

**Syntax:**
```bash
mariaIp <container_name>
```

**Parameters:**
- `container_name` - Name of the container

**Examples:**
```bash
mariaIp myapp_php_1  # Get MariaDB IP from php container
```

**Full Command:** `docker exec <container> ping mariadb`

**Use Cases:**
- Similar to `mysqlIp()` but for MariaDB
- Database connection troubleshooting

---

### ddall()

**Purpose:** Remove ALL Docker containers, images, and volumes (nuclear option)

**Syntax:**
```bash
ddall
```

**Parameters:** None

**⚠️ WARNING:** This is a DESTRUCTIVE operation!

**What it does:**
1. Stops all running containers
2. Removes all containers
3. Removes all images
4. Removes all volumes

**Examples:**
```bash
ddall  # Clean slate - removes everything
```

**Use Cases:**
- Complete Docker cleanup
- Free disk space
- Resolve conflicts
- Start fresh

**Before Running:**
- Backup important data
- Commit code changes
- Export database backups

**Recovery:**
- Run `dbuild && dstart` to rebuild

**Alternatives:**
- `docker system prune` - Less destructive
- `docker volume prune` - Only remove volumes
- `docker image prune` - Only remove images

---

### kdo()

**Purpose:** Kill Docker Desktop application and VM

**Syntax:**
```bash
kdo
```

**Parameters:** None

**Examples:**
```bash
kdo  # Force quit Docker Desktop
```

**What it does:**
- Finds all Docker processes
- Excludes `com.docker.vmnetd` (system service)
- Kills remaining processes

**Use Cases:**
- Docker Desktop not responding
- High CPU usage from Docker
- Before system restart
- Troubleshooting Docker issues

**Note:** Docker Desktop will need to be restarted manually

**Warning:** Only kills the app, not containers. Use `dstop()` first if needed.

---

## Git Functions

Located in: `zsh/config/42-functions-git.zsh`

### dbranch()

**Purpose:** Delete all git branches except the specified one

**Syntax:**
```bash
dbranch <branch_to_keep>
```

**Parameters:**
- `branch_to_keep` - Name of branch to preserve

**Examples:**
```bash
dbranch master       # Delete all branches except master
dbranch main         # Delete all branches except main
dbranch develop      # Delete all branches except develop
```

**⚠️ WARNING:** This is DESTRUCTIVE!

**What it does:**
1. Lists all local branches
2. Filters out the specified branch
3. Deletes all other branches with `git branch -D`

**Use Cases:**
- Cleanup after feature completion
- Remove old test branches
- Prepare for new sprint
- Declutter git branches

**Before Running:**
- Ensure branches are merged or pushed
- Backup any important work
- Double-check branch name

**Common Pattern:**
```bash
git checkout master  # Switch to master
git pull            # Update master
dbranch master      # Delete all other branches
```

**Safety Tip:** Run `git branch` first to see what will be deleted

---

## PHP Testing Functions

Located in: `zsh/config/43-functions-php.zsh`

### p()

**Purpose:** Run Pest or PHPUnit tests automatically

**Syntax:**
```bash
p [arguments]
```

**Parameters:**
- `arguments` - Any arguments to pass to test runner (optional)

**Examples:**
```bash
p                    # Run all tests
p --parallel         # Run tests in parallel (Pest)
p tests/Unit         # Run only Unit tests
p --filter UserTest  # Run specific test
```

**How it works:**
1. Checks if `vendor/bin/pest` exists
2. If yes, runs Pest
3. If no, runs PHPUnit

**Use Cases:**
- Running tests without remembering which runner to use
- Project-agnostic test running
- Quick test execution

**Requirements:**
- `vendor/bin/pest` or `vendor/bin/phpunit`
- Project must be set up with Composer

**Related:**
- `pf()` - Run tests with filter

---

### pf()

**Purpose:** Run Pest or PHPUnit tests with filter

**Syntax:**
```bash
pf <filter_string>
```

**Parameters:**
- `filter_string` - Test name or pattern to filter

**Examples:**
```bash
pf UserTest           # Run tests matching 'UserTest'
pf login              # Run tests with 'login' in name
pf "can create user"  # Run specific test case
```

**Full Command:**
- Pest: `vendor/bin/pest --filter <filter>`
- PHPUnit: `vendor/bin/phpunit --filter <filter>`

**Use Cases:**
- Running single test file
- Running tests for specific feature
- Debugging failing tests
- TDD workflow

**Common Patterns:**
```bash
pf Integration      # Run all integration tests
pf Unit            # Run all unit tests
pf Api             # Run all API tests
```

**Related:**
- `p()` - Run all tests
- `art test` - Laravel's test command

**Tips:**
- Use quotes for multi-word filters
- Filter is case-sensitive
- Can use regex patterns

---

## Function Usage Tips

### Combining Functions

```bash
# Create project and start Docker
create myproject && dbuild && dstart

# Extract and enter directory
extract project.zip && cd project

# Clean Docker and rebuild
ddall && dbuild && dstart

# Test specific feature
pf Authentication && pf Authorization
```

### Checking Function Definitions

```bash
# View function source
type create
type dbuild
type p

# List all functions
functions
```

### Creating Your Own Functions

Add to `zsh/config/99-local.zsh`:

```bash
# Custom function example
myfunction() {
  echo "Hello from custom function"
}
```

## See Also

- [Aliases Reference](ALIASES.md) - All available aliases
- [Installation Guide](INSTALL.md) - Setup instructions
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues

---

**Tip:** Functions are like aliases but can accept parameters and contain logic.

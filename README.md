# dotfiles.cmarks

A personal collection of dotfiles for a productive Unix/Linux development environment, focused on Vim, Bash, Tmux, and related tools.

**Primary Environment**: WSL (Windows Subsystem for Linux) on Windows 10/11, with occasional use on native Linux and macOS.

## Overview

This repository contains configuration for:

- **Bash**: Custom prompt with git status colors, useful aliases, and helper functions.
- **Vim / Neovim**: Classic Vim setup (being modernized) + focus on a new Neovim configuration.
- **Tmux**: Minimal mouse-enabled configuration.
- **Other**: Conky system monitor, custom ctags for JavaScript, and an encrypted vimrc variant.

**Note**: Ruby/Cucumber-specific helpers (e.g. `cucumberStepStat`) have been isolated as legacy code. BDD-style testing is still appreciated but will move to non-Ruby options (Cucumber.js, Python behave, etc.) in the future.

Key files:
- `bashrc` – Sources aliases/functions and sets a git-aware PS1 prompt.
- `bash_aliases` – Navigation, colored ls/grep, history helpers, tmux color fix.
- `bash_functions` – Git prompt color/branch logic (Cucumber/BDD helpers now isolated as legacy).
- `vimrc` – Classic Vim setup (Pathogen + phix colorscheme).
- `encrypted_vimrc` – Minimal secure settings (no backups/swaps).
- `tmux.conf` – Enables mouse support.
- `conkyrc` – System monitor configuration.
- `ctags` – Extended JavaScript tag patterns.
- `install.sh` – Symlink installer (now includes bash_aliases and bash_functions).
- `vim/bundle/` – Legacy Vim plugins (being phased toward modern Neovim setup).

## Prerequisites

Before running the installer you need these core tools (the script will warn if any are missing):

- **vim** and/or **neovim** (nvim)
- **git**
- **tmux**
- **curl**
- **bash** ≥ 4.0

**Quick install commands** (common platforms):

```bash
# Debian / Ubuntu / WSL
sudo apt-get update && sudo apt-get install -y vim neovim git tmux curl

# macOS (Homebrew)
brew install vim neovim git tmux curl
```

Neovim plugins are managed automatically by `lazy.nvim` on first launch.

## Install

```bash
cd ~/dotfiles
./install.sh
```

The script:
1. Creates `~/dotfiles_old/` backup.
2. Moves existing dotfiles and creates symlinks.
3. Initializes git submodules.
4. Sets git defaults (`core.editor=vi`, `color.ui=auto`).
5. Symlinks `nvim/` → `~/.config/nvim`.

**Notes / Current State**:
- Run only once (or after backups).
- Neovim config is now included via symlink to `~/.config/nvim`.
- `bash_aliases` and `bash_functions` are now symlinked.
- Legacy Ruby/Cucumber code has been isolated.
- After install, run `git submodule update --init --recursive` if needed.

## Uninstall

```bash
./uninstall.sh           # Interactive uninstall (restores from backup)
./uninstall.sh --dry-run # Preview what would be removed/restored
./uninstall.sh --force   # Skip confirmation prompt
```

The uninstall script removes all symlinks created by `install.sh`, restores originals from `~/dotfiles_old` when available, and unsets the git configuration changes.

## Quick Start

```bash
cd ~/dotfiles
./install.sh          # Set up symlinks and Neovim config
./uninstall.sh        # Revert everything (with backup restore)
./test.sh             # Run Docker validation (requires Docker)
nvim                  # Launch Neovim (plugins auto-install on first run)
```

## Neovim (Recommended)

Modern Neovim configuration lives in `nvim/`.

This is the **recommended** setup going forward. It coexists with the classic Vim configuration — you can use either.

- Uses `lazy.nvim` for plugin management
- Includes Treesitter, LSP (via Mason), Telescope, bufferline, gitsigns, etc.
- Plugins auto-install on first launch

Manual link (if needed):
```bash
mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim
```

**Note**: The classic `vimrc` and Pathogen plugins remain available for backward compatibility.

## Testing with Docker

This repo includes a Docker-based test to validate the installation in a clean environment.

**Prerequisite**: Docker must be installed (see [Docker Desktop](https://www.docker.com/products/docker-desktop/) for WSL/Windows users).

```bash
# Easy way (recommended)
./test.sh

# Or manually
docker build -t dotfiles-test .
docker run --rm dotfiles-test
```

This will:
- Create a clean Ubuntu container
- Run `install.sh`
- Validate symlinks and basic functionality

Useful when making changes to `install.sh` or the Neovim config.

## Development Workflow: Dev Container (Recommended & Portable)

This is the **primary recommended way** to develop with your full dotfiles environment on Windows while editing files that live on your laptop.

### Dummy's Guide: Using the Dev Container on Windows (Step-by-Step)

**Prerequisites** (do this once):
1. Install [Visual Studio Code](https://code.visualstudio.com/)
2. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/) and make sure it uses the **WSL2 backend** (default on modern installs)
3. In VS Code, install the official **"Dev Containers"** extension by Microsoft (search for "Dev Containers" in Extensions view)

**Everyday usage**:
1. Clone or open this `dotfiles` folder in VS Code
2. When prompted (or press `Ctrl+Shift+P` → type "Dev Containers: Reopen in Container"), click **"Reopen in Container"**
3. Wait for the first build (it installs Neovim, runs `install.sh`, and pre-warms lazy.nvim plugins — can take a few minutes the very first time)
4. Once the container is ready, open the **integrated terminal** in VS Code (`Ctrl+``)
5. You now have:
   - Full Neovim with lazy.nvim + tokyonight + lualine etc.
   - Your custom bash prompt, aliases, git functions
   - tmux available
   - All configs from the dotfiles repo active

**Working with your projects**:
- The folder you opened in VS Code is automatically mounted at `/workspace` inside the container.
- Simply edit files in VS Code (or use `nvim` inside the terminal) — changes are instantly reflected on both sides.
- To work on a different Windows folder, you can add extra mounts in `.devcontainer/devcontainer.json` or use the optional `docker-compose.yml`.

**Exiting / rebuilding**:
- To leave the container: `Ctrl+Shift+P` → "Dev Containers: Reopen Folder Locally"
- To rebuild after changing `Dockerfile.dev` or `.devcontainer/`: `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"

**Windows path tips**:
- Docker Desktop accepts both `C:\path` and `C:/path` styles.
- For extra mounts (SSH keys, etc.) use `${localEnv:USERPROFILE}` in the json.

### Terminal-only Alternative (docker compose)

If you prefer the terminal:

```bash
# Make the script executable once
chmod +x dev.sh

# Start and enter bash
./dev.sh

# Or run a specific command
./dev.sh nvim /workspace/some-file.py
```

Or manually:
```bash
docker compose up -d
docker compose exec dev bash
```

**Environment variables via `.env` file** (recommended for docker compose):

1. Copy `.env.example` → `.env`
2. Edit `.env` and set `HOST_PROJECTS` to the folder you want mounted at `/workspace`
3. Docker Compose automatically reads `.env` — no other changes needed

`.env` is listed in `.gitignore` so your local paths stay private.

### Troubleshooting inside the container (when reporting issues to AI)

When something isn't working inside the Dev Container or `docker compose`, include these outputs when asking for help:

```bash
# From host (PowerShell or WSL)
docker compose logs --tail=100 dev
docker ps
docker inspect <container-id>

# Inside the running container (use VS Code terminal or exec)
docker compose exec dev bash
# Then inside container:
nvim --version
nvim --headless -c 'lua print("lazy check"); vim.cmd("qa")' 2>&1
echo $CONTAINER
ls -la /workspace
cat ~/.config/nvim/init.lua | head -30
```

**Common fixes inside the container**:
- Neovim/lazy issues: `rm -rf ~/.local/share/nvim/lazy && nvim` (forces plugin reinstall)
- Config not loading: `source ~/.bashrc && nvim`
- Permission problems on mounted files: run as root (already default) or `chown -R root:root /workspace`
- Rebuild everything: VS Code → "Dev Containers: Rebuild Container" or `docker compose down --rmi all && docker compose up -d`

## Legacy Vim Setup

The original Vim configuration (still functional) uses [pathogen.vim](https://github.com/tpope/vim-pathogen) with git submodules.

### Legacy Plugins

Current submodules (from `.gitmodules`):
- vim-pathogen, vim-fugitive, vim-colors-solarized, vim-javascript, vim-snippets, vim-snipmate, vim-addon-mw-utils, tlib-vim, vim-cucumber, vim-syntastic, vim-airline, vim-gitgutter, spink, vim-unimpaired, supertab, vim-trailing-whitespace, vim-phix-colors.

Use these only if you prefer classic Vim. New development should use the Neovim configuration above.

## Special Features

- **Git-aware Bash Prompt**: Shows current directory + branch in color (green=clean, red=dirty, yellow=ahead, ochre=other).
- **Enhanced ctags**: Custom regexes for modern JavaScript (objects, functions, variables, arrays, primitives).

### Legacy Features

- **Cucumber Step Statistics** (`cucumberStepStat`): Kept for reference. The author prefers BDD-style testing but no longer works with Ruby. Consider Cucumber.js or Python's `behave` as modern alternatives.

## FAQ

##### Vim airline theme doesn't look right
Install Powerline fonts: [powerline/fonts](https://github.com/powerline/fonts)

##### I need to update the vim bundle submodules
```bash
git submodule update --init --recursive
```
See [Stack Overflow](https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin)

##### How do I add a new Vim plugin?
1. Add it as a submodule under `vim/bundle/`.
2. Update `.gitmodules`.
3. Run `git submodule update --init --recursive`.

## Contributing / Notes

This is a personal setup originally from around 2010, significantly modernized in 2026.

- **Neovim** is now the primary focus (with `lazy.nvim`, LSP, Treesitter, etc.).
- Classic Vim + Pathogen setup is preserved for backward compatibility.
- Docker-based testing was added for safer development.
- Legacy Ruby/Cucumber helpers have been isolated.

The project serves as both a daily driver and a learning/practice environment while returning to development after a 10-year break.

Feel free to fork and adapt!

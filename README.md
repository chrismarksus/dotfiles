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

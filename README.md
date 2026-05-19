# dotfiles.cmarks

A personal collection of dotfiles for a productive Unix/Linux development environment, focused on Vim, Bash, Tmux, and related tools.

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
- `bash_functions` – Git prompt color/branch logic (Cucumber/BDD helpers isolated as legacy).
- `vimrc` – Classic Vim setup (Pathogen + phix colorscheme).
- `encrypted_vimrc` – Minimal secure settings (no backups/swaps).
- `tmux.conf` – Enables mouse support.
- `conkyrc` – System monitor configuration.
- `ctags` – Extended JavaScript tag patterns.
- `install.sh` – Symlink installer (now includes bash_aliases and bash_functions).
- `vim/bundle/` – Legacy Vim plugins (being phased toward modern Neovim setup).

## Install

```bash
cd ~/dotfiles
./install.sh
```

The script:
1. Creates `~/dotfiles_old/` backup.
2. Moves existing dotfiles and creates symlinks (`~/.bashrc`, `~/.vimrc`, `~/.vim`, `~/.tmux.conf`, etc.).
3. Initializes git submodules.
4. Sets git defaults (`core.editor=vi`, `color.ui=auto`).

**Notes / Current State**:
- Run only once (or after backups).
- `install.sh` references `secure_vimrc` which has been renamed to `encrypted_vimrc`.
- `bash_aliases` and `bash_functions` are sourced by `bashrc` but not automatically symlinked.
- After install, run `git submodule update --init --recursive` if needed.

## Vim Plugins

Plugins are managed via [pathogen.vim](https://github.com/tpope/vim-pathogen) and stored as git submodules in `vim/bundle/`.

Current submodules (from `.gitmodules`):
- vim-pathogen, vim-fugitive, vim-colors-solarized, vim-javascript, vim-snippets, vim-snipmate, vim-addon-mw-utils, tlib-vim, vim-cucumber, vim-syntastic, vim-airline, vim-gitgutter, spink, vim-unimpaired, supertab, vim-trailing-whitespace, vim-phix-colors.

See also the original plugin list in the history or FAQ below for links.

## Special Features

- **Git-aware Bash Prompt**: Shows current directory + branch in color (green=clean, red=dirty, yellow=ahead, ochre=other).
- **Cucumber Step Statistics**: `cucumberStepStat /path/to/project` reports usage of Given/When/Then steps in feature files vs. step definitions + file-type breakdown.
- **Enhanced ctags**: Custom regexes for modern JavaScript (objects, functions, variables, arrays, primitives).

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

This is a personal setup from around 2010 with various updates over the years. Some plugins are older (Syntastic, Pathogen) and may benefit from modern alternatives (e.g., ALE or coc.nvim, vim-plug). The Cucumber functions suggest heavy BDD/Ruby usage in the past.

Feel free to fork and adapt!

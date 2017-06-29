# dotfiles.cmarks

dot files are hidden configuration files. The files start with a '.' like .vimrc
and .bashrc.

## Install

Run the script in the dotfile folder. It will move your files and create symlinks. But only run it once it is only a basic startup script.

## Plugins

vim plugins are added as git submodules when possible. There are also managed by
the pathogen plugin.

[pathogen](https://github.com/tpope/vim-pathogen),
[snipmate](https://github.com/garbas/vim-snipmate),
[snippets](https://github.com/honza/vim-snippets),
[javascript](https://github.com/pangloss/vim-javascript),
[fugitive](https://github.com/tpope/vim-fugitive),
[cucumber](https://github.com/tpope/vim-cucumber), and
[solarized](https://github.com/altercation/vim-colors-solarized)
[syntastic](https://github.com/scrooloose/syntastic)

## FAQ

##### Vim airline theme doesn't look right
The correct fonts maybe not be installed see [powerline fonts](https://github.com/powerline/fonts)

##### I need to update the vim bundle submodules
use ```git submodule update --init --recursive``` see [StackOverflow](https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin)

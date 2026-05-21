#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# Dependency checks (non-fatal by default)
check_dependency() {
    local cmd=$1
    local pkg=$2
    if ! command -v "$cmd" &> /dev/null; then
        echo "⚠ $cmd not found. Install with:"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "  brew install $pkg"
        elif [[ -f /etc/debian_version ]]; then
            echo "  sudo apt-get install -y $pkg"
        else
            echo "  (use your package manager to install $pkg)"
        fi
        return 1
    fi
    return 0
}

echo "Checking core dependencies..."
check_dependency vim vim || true
check_dependency nvim neovim || true
check_dependency git git || true
check_dependency tmux tmux || true
check_dependency curl curl || true
# Bash version check (require >= 4)
if [ "${BASH_VERSION%%.*}" -lt 4 ]; then
    echo "⚠ Bash < 4 detected. Some features may not work."
fi
echo "...dependency check complete"

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim encrypted_vimrc tmux.conf bash_aliases bash_functions ctags"  # files/folders to symlink in homedir

##########

# create dotfiles_old in homedir

mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [[ -h ~/.$file ]]; then
        echo "A symbolic link for $file already exists. Deleting link!"
        rm ~/.$file
    else
        if [ -e ~/.$file ]; then
            echo "Moving any existing dotfiles from ~ to $olddir"
            mv ~/.$file ~/dotfiles_old/
        fi
    fi

    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

git submodule update --init --recursive || true
git config --global core.editor vi
git config --global color.ui auto

# Neovim configuration symlink (to ~/.config/nvim)
echo "Setting up Neovim configuration..."
mkdir -p ~/.config
if [ -d ~/.config/nvim ] || [ -L ~/.config/nvim ]; then
    echo "Backing up existing Neovim config to $olddir/nvim"
    mv ~/.config/nvim "$olddir/nvim"
fi
ln -s "$dir/nvim" ~/.config/nvim
echo "Neovim config symlinked to ~/.config/nvim"

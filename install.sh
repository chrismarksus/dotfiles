#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim encrypted_vimrc tmux.conf bash_aliases bash_functions"  # files/folders to symlink in homedir

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
        echo "Moving any existing dotfiles from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
    fi

    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

git submodule update --init --recursive
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

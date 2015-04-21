#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim secure_vimrc tmux.conf"          # list of files/folders to symlink in homedir

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
        echo "A symblic link for $file already exists, Deleteing link!"
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

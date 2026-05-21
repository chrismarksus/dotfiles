#!/bin/bash
############################
# uninstall.sh - Reverts changes made by install.sh
############################

set -e

########## Variables (mirrors install.sh)

dir=~/dotfiles
olddir=~/dotfiles_old
files="bashrc vimrc vim encrypted_vimrc tmux.conf bash_aliases bash_functions ctags"

########## Flags

DRY_RUN=false
FORCE=false
NO_RESTORE=false

for arg in "$@"; do
    case $arg in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force|-f)
            FORCE=true
            shift
            ;;
        --no-restore)
            NO_RESTORE=true
            shift
            ;;
    esac
done

run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        echo "DRY-RUN: $*"
    else
        eval "$@"
    fi
}

########## Confirmation

if [ "$DRY_RUN" = false ] && [ "$FORCE" = false ]; then
    echo "This will remove symlinks created by install.sh and restore originals from $olddir (if present)."
    read -p "Proceed with uninstall? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Uninstall cancelled."
        exit 0
    fi
fi

echo "Starting uninstall..."

########## Remove symlinks and restore backups

cd "$dir" || { echo "Cannot cd to $dir"; exit 1; }

for file in $files; do
    target="$HOME/.$file"

    if [ -L "$target" ]; then
        link_target=$(readlink "$target")
        if [[ "$link_target" == "$dir/$file" ]]; then
            echo "Removing symlink: $target"
            run_cmd rm "$target"
        else
            echo "Skipping $target (not pointing to this repo)"
        fi
    elif [ -e "$target" ]; then
        echo "Skipping $target (not a symlink)"
    fi

    # Restore from backup
    if [ "$NO_RESTORE" = false ] && [ -e "$olddir/$file" ]; then
        echo "Restoring $file from backup..."
        run_cmd mv "$olddir/$file" "$HOME/.$file"
    fi
done

########## Neovim config

nvim_target="$HOME/.config/nvim"
if [ -L "$nvim_target" ]; then
    link_target=$(readlink "$nvim_target")
    if [[ "$link_target" == "$dir/nvim" ]]; then
        echo "Removing Neovim symlink: $nvim_target"
        run_cmd rm "$nvim_target"
    fi
fi

if [ "$NO_RESTORE" = false ] && [ -e "$olddir/nvim" ]; then
    echo "Restoring Neovim config from backup..."
    run_cmd mv "$olddir/nvim" "$HOME/.config/nvim"
fi

########## Revert git configuration

echo "Reverting git configuration..."
run_cmd 'git config --global --unset core.editor || true'
run_cmd 'git config --global --unset color.ui || true'

########## Summary

if [ "$DRY_RUN" = true ]; then
    echo ""
    echo "=== DRY RUN COMPLETE ==="
    echo "No changes were made. Run without --dry-run to apply."
else
    echo ""
    echo "=== Uninstall complete ==="
    echo "Symlinks removed. Git config reverted."
    if [ "$NO_RESTORE" = false ]; then
        echo "Restored files from $olddir where available."
    fi
    echo ""
    echo "You may now safely remove ~/dotfiles if desired."
fi

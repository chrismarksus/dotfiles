#!/bin/bash
# Basic validation script for dotfiles installation

set -e

echo "=== Validating dotfiles installation ==="

# Check symlinks
echo "Checking symlinks..."
[ -L "$HOME/.bashrc" ] && echo "✓ .bashrc symlinked" || echo "✗ .bashrc missing"
[ -L "$HOME/.vimrc" ] && echo "✓ .vimrc symlinked" || echo "✗ .vimrc missing"
[ -L "$HOME/.config/nvim" ] && echo "✓ Neovim config symlinked" || echo "✗ Neovim config missing"
[ -L "$HOME/.tmux.conf" ] && echo "✓ .tmux.conf symlinked" || echo "✗ .tmux.conf missing"

# Check that bash functions can be sourced
echo "Testing bash functions..."
source "$HOME/.bashrc" 2>/dev/null || echo "⚠ Could not source .bashrc (may be ok)"

# Test Neovim startup
echo "Testing Neovim..."
if command -v nvim &> /dev/null; then
    nvim --headless -c "q" 2>/dev/null && echo "✓ Neovim starts successfully" || echo "⚠ Neovim had issues"
else
    echo "⚠ Neovim not found in PATH"
fi

echo ""
echo "=== Validation complete ==="
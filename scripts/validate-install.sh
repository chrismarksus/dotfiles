#!/bin/bash
# Enhanced validation script for dotfiles installation

set +e  # Continue on errors for full reporting

echo "=== Validating dotfiles installation ==="
echo ""

PASS=0
FAIL=0

check() {
    if eval "$1"; then
        echo "✓ $2"
        ((PASS++))
    else
        echo "✗ $2"
        ((FAIL++))
    fi
}

echo "Checking symlinks..."
check '[ -L "$HOME/.bashrc" ]'           ".bashrc is symlinked"
check '[ -L "$HOME/.vimrc" ]'            ".vimrc is symlinked"
check '[ -L "$HOME/.config/nvim" ]'      "Neovim config is symlinked"
check '[ -L "$HOME/.tmux.conf" ]'        ".tmux.conf is symlinked"
check '[ -L "$HOME/.bash_aliases" ]'     "bash_aliases is symlinked"
check '[ -L "$HOME/.bash_functions" ]'   "bash_functions is symlinked"
echo ""

echo "Checking git configuration..."
check 'git config --global core.editor | grep -q vi' "git core.editor set to vi"
check 'git config --global color.ui | grep -q auto'  "git color.ui set to auto"
echo ""

echo "Testing bash environment..."
if source "$HOME/.bashrc" 2>/dev/null; then
    echo "✓ .bashrc sources without error"
    ((PASS++))
else
    echo "✗ .bashrc failed to source"
    ((FAIL++))
fi

# Check for key functions
if declare -F git_branch &>/dev/null; then
    echo "✓ git_branch function available"
    ((PASS++))
else
    echo "✗ git_branch function missing"
    ((FAIL++))
fi
echo ""

echo "Testing Neovim..."
if command -v nvim &> /dev/null; then
    if nvim --headless --clean -c "lua print('Neovim Lua works')" -c "q" &>/dev/null; then
        echo "✓ Neovim starts and runs Lua"
        ((PASS++))
    else
        echo "✗ Neovim failed to start properly"
        ((FAIL++))
    fi
else
    echo "⚠ Neovim not found in PATH"
fi
echo ""

echo "=== Validation Summary ==="
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "✓ All checks passed!"
    exit 0
else
    echo "✗ Some checks failed"
    exit 1
fi
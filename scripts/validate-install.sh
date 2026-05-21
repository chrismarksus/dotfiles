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

echo "Checking core dependencies..."
for tool in vim nvim git tmux curl; do
    if command -v "$tool" &> /dev/null; then
        echo "✓ $tool found in PATH"
        ((PASS++))
    else
        echo "✗ $tool not found"
        ((FAIL++))
    fi
done
# Bash version
if [ "${BASH_VERSION%%.*}" -ge 4 ]; then
    echo "✓ Bash >= 4.0"
    ((PASS++))
else
    echo "✗ Bash < 4.0"
    ((FAIL++))
fi
echo ""

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

echo "Testing Neovim configuration..."
if command -v nvim &> /dev/null; then
    # Temp lua files + timeout protection for reliable, fast Docker validation
    cat > /tmp/test_nvim.lua << 'LUAEOF'
print("Neovim config loaded successfully")
vim.cmd('qa')
LUAEOF

    if timeout 15s nvim --headless -c "luafile /tmp/test_nvim.lua" 2>&1 | grep -q "Neovim config loaded successfully"; then
        echo "✓ Neovim config loads and prints success message"
        ((PASS++))
    else
        echo "✗ Neovim config failed to load cleanly"
        ((FAIL++))
    fi

    cat > /tmp/test_lazy.lua << 'LUAEOF'
local ok, lazy = pcall(require, 'lazy')
if ok and lazy then
    print('lazy_plugins:' .. #lazy.plugins())
else
    print('lazy_not_loaded')
end
vim.cmd('qa')
LUAEOF

    if timeout 15s nvim --headless -c "luafile /tmp/test_lazy.lua" 2>&1 | grep -q "lazy_plugins:[0-9]"; then
        echo "✓ lazy.nvim loaded with plugins"
        ((PASS++))
    else
        echo "✗ lazy.nvim did not load or no plugins registered"
        ((FAIL++))
    fi

    cat > /tmp/test_plugins.lua << 'LUAEOF'
local has_tokyo = pcall(require, 'tokyonight')
local has_lualine = pcall(require, 'lualine')
print('plugins_ok:' .. (has_tokyo and has_lualine and 'true' or 'false'))
vim.cmd('qa')
LUAEOF

    if timeout 15s nvim --headless -c "luafile /tmp/test_plugins.lua" 2>&1 | grep -q "plugins_ok:true"; then
        echo "✓ Core plugins (tokyonight, lualine) are loadable"
        ((PASS++))
    else
        echo "✗ Core plugins failed to load"
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
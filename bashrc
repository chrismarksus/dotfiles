# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#Source alias definitions
if [ -f ~/dotfiles/bash_aliases ]; then
    . ~/dotfiles/bash_aliases
fi

#Source alias definitions
if [ -f ~/dotfiles/bash_functions ]; then
    . ~/dotfiles/bash_functions
fi

PS1="\[$COLOR_WHITE\]\n[\W]"          # basename of pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_BLUE\]\[$COLOR_RESET\]\$ "   # '#' for root, else '$'
export PS1

# Local must stay at the bottom so it can override the above configure
# Source local definitions
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

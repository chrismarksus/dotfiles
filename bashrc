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

export PS1='\u@\h \[\033[1;33m\]\W\[\033[0m\]$(parse_git_branch)$ '

# Local must stay at the bottom so it can override the above configure
# Source local definitions
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

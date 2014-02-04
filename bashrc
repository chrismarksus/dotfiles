# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#Source alias definitions
if [ -f ~/.bashrc_aliases ]; then
    . ~/.bashrc_aliases
fi

#Source local definitions
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1='\u@\h \[\033[1;33m\]\W\[\033[0m\]$(parse_git_branch)$ '

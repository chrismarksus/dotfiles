# bash_aliases file

alias ls='ls --color=auto'
alias ll='ls -al'
alias l.='ls -d .*'
alias lh='ls -al --color=yes -lasth | less -R'

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

#Colorize the grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias edit='vim'
alias vimenc "vim -u ~/encrypted_vim_rc -x"

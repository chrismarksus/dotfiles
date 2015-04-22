# bash_aliases file

alias ls='ls --color=auto'
alias ll='ls -hal --color=auto'
alias l.='ls -d .* --color=auto'
alias lh='ls -al --color=yes -lasth | less -R'

alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# History
alias hig='history|grep '

# Disk usage
alias most='du -hsx * | sort -rh | head -10'
alias du="du -h"
alias df="df -h"

# Ruby, rake, bundle, gem etc...
alias bake='bundle exec rake'

#Colorize the grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias edit='vim'
#alias vimenc "vim -u ~/encrypted_vim_rc -x"

# fix the colors when using vim inside tmux
alias tmux='tmux -2'

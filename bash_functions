# bash_functions file

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# Count all the file in a directory by file extension
function countFilesByExtension(){
  find "$1" -type f | rev | cut -d . -f1 | rev | sort | uniq -ic | sort -rn
}

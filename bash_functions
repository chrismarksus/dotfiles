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

# Report the number of cucumber step used bt type
# Just cd to your root cucumber directory and call the method
function cucumberStepStat(){

    features_dir="$1features/"
    step_dir="$1features/step_definitions/"
    gherkin_array=("Given" "When" "Then" "And" "But" "\*")

    function _getStep(){
        regex="^[ ]*($1)"
        grep -rhE "$regex" "$step_dir" | wc -l
    }

    function _getStepInFeatures(){
        regex="^[ ]*($1)"
        grep -rhE "$regex" "$features_dir" --exclude-dir=step_definitions --exclude-dir=support | wc -l
    }

    function _printStep(){
        echo -e "\e[36m$(_getStep $1) \e0\e[37\e[1m$1\e[0m steps used \e[94m$(_getStepInFeatures $1)\e0\e[37m times in feature files!"
    }

    echo ""
    echo "Gherkin step definition report:"
    echo ""
    for i in "${gherkin_array[@]}"
    do
        _printStep "$i"
    done
    echo -e "For a total of \e[36m"$(_getStep "Given|When|Then|And|But|\*")"\e0\e[37m steps!"
    echo -e "And a total of \e[94m"$(_getStepInFeatures "Given|When|Then|And|But|\*")"\e0\e[37m steps used in feature files!"
    echo ""
    echo "Total file by extension:"
    find "$features_dir" -type f | rev | cut -d . -f1 | rev | sort | uniq -ic | sort -rn
    echo ""

}

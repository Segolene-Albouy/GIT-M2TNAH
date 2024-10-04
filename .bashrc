BRANCH=""

function git_branch() {
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
        local branch_name=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)

        if [ -n "$branch_name" ]; then
            echo "$branch_name"
        fi
    fi
}

color_echo() {
    Color_Off="\033[0m"
    Red="\033[1;91m"        # Red
    Green="\033[1;92m"      # Green
    Yellow="\033[1;93m"     # Yellow
    Blue="\033[1;94m"       # Blue
    Purple="\033[1;95m"     # Purple
    Cyan="\033[1;96m"       # Cyan

    case "$1" in
        "green") echo -e "$Green$2$Color_Off";;
        "red") echo -e "$Red$2$Color_Off";;
        "blue") echo -e "$Blue$2$Color_Off";;
        "yellow") echo -e "$Yellow$2$Color_Off";;
        "purple") echo -e "$Purple$2$Color_Off";;
        "cyan") echo -e "$Cyan$2$Color_Off";;
        *) echo "$2";;
    esac
}

function pre_prompt() {
    if [ "$(git_branch)" != "$BRANCH" ]; then
        BRANCH=$(git_branch)
    fi

    local git=""
    if [ -n "$BRANCH" ]; then
        git=$(colorEcho "purple" "[$BRANCH]")
    fi

    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv=$(colorEcho "blue" "($(basename $VIRTUAL_ENV))")
    elif [ -n "$CONDA_DEFAULT_ENV" ]; then
        venv=$(colorEcho "blue" "($CONDA_DEFAULT_ENV)")
    fi

     local user="$(color_echo "red" "\u")"
     local host="$(color_echo "yellow" "\h")"
     local working_dir="$(color_echo "cyan" "$(pwd)")"
     PS1="$user@$host$:$working_dir $git$venv $ "
}

pre_prompt

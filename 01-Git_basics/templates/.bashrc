BRANCH=""

git_branch() {
    # Fonction pour récupérer le nom de la branch courante
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
        local branch_name=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)

        if [ -n "$branch_name" ]; then
            echo "$branch_name"
        fi
    fi
}

get_color() {
    color="${1:-white}"
    style="${2:-0}" # 0 (normal) / 1 (bold) / 2 (dim) / 3 (italic) / 4 (underline) / 5 (blink) / 7 (reverse) / 8 (hidden)
    is_bright="${3:-0}" # 0 or 1

    shade=""
    if [ "$is_bright" = 1 ]; then
        shade="9"
    else
        shade="3"
    fi

    case "$color" in
        "black") echo "\[\033[${style};${shade}0m\]";;
        "red") echo "\[\033[${style};${shade}1m\]";;
        "green") echo "\[\033[${style};${shade}2m\]";;
        "yellow") echo "\[\033[${style};${shade}3m\]";;
        "blue") echo "\[\033[${style};${shade}4m\]";;
        "purple") echo "\[\033[${style};${shade}5m\]";;
        "cyan") echo "\[\033[${style};${shade}6m\]";;
        "white") echo "\[\033[${style};37m\]";;
        "gray") echo "\[\033[${style};90m\]";;
        *) echo "\[\033[0m\]";; # Default color
    esac
}

color_echo() {
    msg=$2
    # color / style / is_bright
    color=$(get_color $1 $3 $4)

    color_off='\[\033[0m\]'
    echo "${color}${msg}${color_off}"
}

TODAY=$(date +%m-%d)

function get_emoji() {
    if [ "$TODAY" = "12-24" ]; then
        echo "🎄"
    elif [ "$TODAY" = "05-20" ]; then
        echo "🎂"
    else
        echo "🔥"
    fi
}

pre_prompt() {
    # Fonction pour personnaliser l'invite de commande

    if [ "$(git_branch)" != "$BRANCH" ]; then
        BRANCH=$(git_branch)
    fi

    local git=""
    if [ -n "$BRANCH" ]; then
        git=$(color_echo "purple" "[$BRANCH]")
    fi

    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv=$(color_echo "blue" "($(basename $VIRTUAL_ENV))")
    elif [ -n "$CONDA_DEFAULT_ENV" ]; then
        venv=$(color_echo "blue" "($CONDA_DEFAULT_ENV)" "3")
    fi

     local user="$(color_echo "white" "\u" "1")"
     local host="$(color_echo "white" "\h")"
     local working_dir="$(color_echo "grey" "$(pwd)")"

     local emoji=$(get_emoji)

     # utilisateur@hôte:dossier_courant [branche] (environnement virtuel)
     # PS1="$user@$host:$working_dir $git$venv $ "
     # utilisateur:dossier_courant [branche] (environnement virtuel)
     PS1="$user:$working_dir $emoji $git$venv $ "
}

# Pour rétablir l'invite de commande par défaut, commenter la ligne suivante (ajouter un # au début)
PROMPT_COMMAND=pre_prompt

# Commande pour voir la différence entre sa branche locale et la branche remote
alias gdiff='git fetch && git diff $(git_branch) origin/$(git_branch)'
# Commande pour afficher les logs selon le format "commit_hash (utilisateur) commit_msg"
alias glog='git log --pretty=format:"%C(yellow)%h%C(reset)  (%C(green)%cn%C(reset))  %s"'
# Commande pour ouvrir le bashrc et le recharger automatiquement une fois sorti de l'éditeur
alias bashrc='nano ~/.bashrc && source ~/.bashrc'

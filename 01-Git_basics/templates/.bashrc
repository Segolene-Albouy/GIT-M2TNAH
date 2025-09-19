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

color_echo() {
    # Fonction pour colorer le texte
    Color_Off='\[\033[0m\]'
    Red='\[\033[1;91m\]'
    Green='\[\033[1;92m\]'
    Yellow='\[\033[1;93m\]'
    Blue='\[\033[1;94m\]'
    Purple='\[\033[1;95m\]'
    Cyan='\[\033[1;96m\]'

    case "$1" in
        "green") echo "${Green}$2${Color_Off}";;
        "red") echo "${Red}$2${Color_Off}";;
        "blue") echo "${Blue}$2${Color_Off}";;
        "yellow") echo "${Yellow}$2${Color_Off}";;
        "purple") echo "${Purple}$2${Color_Off}";;
        "cyan") echo "${Cyan}$2${Color_Off}";;
        *) echo "$2";;
    esac
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
        venv=$(color_echo "blue" "($CONDA_DEFAULT_ENV)")
    fi

     local user="$(color_echo "red" "\u")"
     local host="$(color_echo "yellow" "\h")"
     local working_dir="$(color_echo "cyan" "$(pwd)")"

     # utilisateur@hôte:dossier_courant [branche] (environnement virtuel)
     # PS1="$user@$host:$working_dir $git$venv $ "
     # utilisateur:dossier_courant [branche] (environnement virtuel)
     PS1="$user:$working_dir $git$venv $ "
}

# Pour rétablir l'invite de commande par défaut, commenter la ligne suivante (ajouter un # au début)
PROMPT_COMMAND=pre_prompt

# Commande pour voir la différence entre sa branche locale et la branche remote
alias gdiff='git fetch && git diff $(git_branch) origin/$(git_branch)'
# Commande pour afficher les logs selon le format "commit_hash (utilisateur) commit_msg"
alias glog='git log --pretty=format:"%C(yellow)%h%C(reset)  (%C(green)%cn%C(reset))  %s"'
# Commande pour ouvrir le bashrc et le recharger automatiquement une fois sorti de l'éditeur
alias bashrc='nano ~/.bashrc && source ~/.bashrc'

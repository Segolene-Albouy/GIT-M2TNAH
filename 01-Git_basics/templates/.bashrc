# ============================================================
#  Terminal M2 TNAH : branche git dans l'invite + raccourcis git
# ============================================================

# Ne rien faire si le terminal n'est pas interactif
case $- in *i*) ;; *) return ;; esac

# ---------- Réglages ----------

# Afficher un emoji dans l'invite : 1 = oui, 0 = non
SHOW_EMOJI=0
# Date d'anniversaire pour l'emoji 🎂 (format MM-JJ, ex. 05-20)
BDAY="MM-DD"

# ---------- Différences entre bash et zsh ----------

ESC=$'\033'
if [ -n "$ZSH_VERSION" ]; then
    RC_FILE=~/.zshrc
    P_USER='%n'; P_HOST='%m'; P_DIR='%~'; P_END='%(!.#.$)'
    P_OPEN='%{'; P_CLOSE='%}'
else
    RC_FILE=~/.bashrc
    P_USER='\u'; P_HOST='\h'; P_DIR='\w'; P_END='\$'
    P_OPEN='\['; P_CLOSE='\]'
fi

# ---------- Couleurs ----------

get_color() {
    color="${1:-white}"
    style="${2:-0}"     # 0 (normal) / 1 (gras) / 2 (pâle) / 3 (italique) / 4 (souligné)
    is_bright="${3:-0}" # 0 ou 1

    shade="3"
    [ "$is_bright" = 1 ] && shade="9"

    case "$color" in
        "black")  code="${shade}0" ;;
        "red")    code="${shade}1" ;;
        "green")  code="${shade}2" ;;
        "yellow") code="${shade}3" ;;
        "blue")   code="${shade}4" ;;
        "purple") code="${shade}5" ;;
        "cyan")   code="${shade}6" ;;
        "white")  code="37" ;;
        "gray")   code="90" ;;
        *)        code="0" ;;
    esac
    echo "${P_OPEN}${ESC}[${style};${code}m${P_CLOSE}"
}

# Usage : color_echo <couleur> <texte> [style] [is_bright]
color_echo() {
    echo "$(get_color "$1" "$3" "$4")$2${P_OPEN}${ESC}[0m${P_CLOSE}"
}

# ---------- Informations affichées ----------

# Nom de la branche courante (ou hash du commit si aucune branche n'est active)
git_branch() {
    git symbolic-ref --short -q HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

get_emoji() {
    case $(date +%m-%d) in
        12-24) echo "🎄" ;;
        $BDAY) echo "🎂" ;;
        *)     echo "🔥" ;;
    esac
}

# ---------- Invite de commande ----------

pre_prompt() {
    BRANCH=$(git_branch)
    ENV_NAME=${VIRTUAL_ENV##*/}
    ENV_NAME=${ENV_NAME:-$CONDA_DEFAULT_ENV}

    # En zsh, un % dans un nom de branche serait interprété : on le double
    if [ -n "$ZSH_VERSION" ]; then
        BRANCH=${BRANCH//\%/%%}
        ENV_NAME=${ENV_NAME//\%/%%}
    fi

    local git="" env="" emoji=""
    [ -n "$BRANCH" ] && git=$(color_echo "purple" ' [$BRANCH]')
    [ -n "$ENV_NAME" ] && env=$(color_echo "blue" ' ($ENV_NAME)')
    [ "$SHOW_EMOJI" = 1 ] && emoji=" $(get_emoji)"

    local user=$(color_echo "white" "$P_USER" "1")
    local host=$(color_echo "white" "$P_HOST")
    local dir=$(color_echo "gray" "$P_DIR")
    local end=$(color_echo "white" "$P_END")

    # utilisateur@hôte:dossier [branche] (environnement) $
    # PS1="$user@$host:$dir$git$env $end "

    # utilisateur:dossier emoji [branche] (environnement) $
    # PS1="$user:$dir$emoji$git$env $end "

    # utilisateur:dossier [branche] (environnement) $
    PS1="$user:$dir$emoji$git$env $end "
}

# Exécuter pre_prompt avant chaque nouvelle ligne de commande
# (pour rétablir l'invite par défaut, commenter ce bloc)
if [ -n "$ZSH_VERSION" ]; then
    setopt PROMPT_SUBST
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd pre_prompt
else
    case ";$PROMPT_COMMAND;" in
        *";pre_prompt;"*) ;;
        *) PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND%;};}pre_prompt" ;;
    esac
fi

# ---------- Raccourcis ----------

# Retire d'éventuels anciens alias portant le même nom que les fonctions ci-dessous
unalias gdiff bashrc reset_bashrc 2>/dev/null

# Historique compact : hash (auteur) message
alias glog='git log --pretty=format:"%C(yellow)%h%C(reset)  (%C(green)%an%C(reset))  %s"'

# Différences entre la branche locale et sa version distante (à partir du cours 2)
gdiff() { git fetch && git diff HEAD "@{upstream}" "$@"; }

# Ouvrir la configuration du terminal, puis la recharger à la fermeture de l'éditeur
bashrc() { nano "$RC_FILE" && . "$RC_FILE"; }

# Restaurer la sauvegarde faite avant l'installation de cette configuration
reset_bashrc() {
    if [ -f "$RC_FILE.bak" ]; then
        cp "$RC_FILE.bak" "$RC_FILE" && echo "Configuration restaurée : ouvrez un nouveau terminal"
    else
        echo "Aucune sauvegarde trouvée ($RC_FILE.bak)"
    fi
}

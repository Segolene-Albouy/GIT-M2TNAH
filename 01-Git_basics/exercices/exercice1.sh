# Installer git
sudo apt-get install git

# Configurer son utilisateur git de manière globale
git config --global user.name "<github-user>"
git config --global user.email "<github-email>"

# Définition de l’éditeur de par défaut
git config --global core.editor "nano"

# Configuration de la coloration par défaut
git config --global color.ui auto

# Configuration du nom de la branche par défaut
git config --global init.defaultBranch main

# Créer le dossier où initialiser le repository
mkdir git_basics

# Se placer dans le dossier
cd git_basics

# Initialiser le repository
git init

# Lister tous le contenu du repository
ls -a

# (un dossier caché .git/ a été créé !)

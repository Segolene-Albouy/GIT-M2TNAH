# EXERCICE 1 : INSTALLER ET CONFIGURER GIT

# 1. Installer git
sudo apt-get update
sudo apt install git

# Vérifier l'installation
git --version

# 2. Configurer son utilisateur (⚠️ même nom et email que sur GitHub)
git config --global user.name "<github-user>"
git config --global user.email "<github-email>"

# 3. Configurer git
git config --global core.editor "nano"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global pull.rebase false

# 4. Vérifier la configuration
git config --list
# ✅ user.name et user.email apparaissent dans la liste

# 5. (Facultatif) Personnaliser son terminal
cp ~/.bashrc ~/.bashrc.bak
curl -s https://raw.githubusercontent.com/Segolene-Albouy/GIT-M2TNAH/refs/heads/main/01-Git_basics/templates/.bashrc >> ~/.bashrc
source ~/.bashrc

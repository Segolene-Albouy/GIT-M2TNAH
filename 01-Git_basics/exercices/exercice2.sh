# EXERCICE 2 : CRÉER SON REPOSITORY DE NOTE DE LECTURE

# 1. Créer le dossier dans son dossier personnel
mkdir ~/note-de-lecture

# 2. L'ouvrir dans VSCode (File > Open Folder…)
cd ~/note-de-lecture

# 3. Depuis le terminal intégré (Ctrl+`) initialiser le repository
git init

# 4. Créer les fichiers README.md, chapitres et brouillon.txt

# 5. Lister les fichiers : tous apparaissent dans "Fichiers non suivis"
git status

# 6. Ajouter uniquement le README, vérifier, puis commiter
git add README.md
git status
# → README.md est dans "Modifications qui seront validées", les autres restent non suivis
git commit -m "docs: création de la notice du mémoire"

# 7. Ajouter tous les fichiers chapitres en une seule commande, puis commiter
git add chapitre-*.md
git commit -m "feat: création des fiches chapitres"

# 8. brouillon.txt n'est jamais ajouté

# Vérification
git log --oneline
# → 2 commits apparaissent
git status
# → seul brouillon.txt reste dans "Fichiers non suivis"

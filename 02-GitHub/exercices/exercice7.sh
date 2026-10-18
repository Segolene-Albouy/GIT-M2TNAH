# Exercice 7 : Ignorer son brouillon

# 1. Se placer dans son repository
cd note-de-lecture

# 2. brouillon.txt apparaît dans les fichiers non suivis
git status

# 3. Créer le .gitignore (ou depuis VSCode : nouveau fichier ".gitignore")
echo "brouillon.txt" > .gitignore

# 4. brouillon.txt a disparu, .gitignore apparaît
git status

# 5. Commiter le .gitignore
git add .gitignore
git commit -m "feat: ajout d'un .gitignore pour le brouillon"

# ✅ "rien à valider, la copie de travail est propre"
git status

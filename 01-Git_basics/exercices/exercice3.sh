# EXERCICE 3 : RÉSUMER UN CHAPITRE
# Les fichiers sont à modifier dans VSCode

# 1. Compléter le titre du chapitre et rédiger les 5 points

# 2. Inspecter les modifications
git status
# → chapitre-X.md est dans "Modifications qui ne seront pas validées"
git diff
# → lignes supprimées en rouge (-), lignes ajoutées en vert (+)

# 3. Ajouter le fichier à la staging area
git add chapitre-X.md
git diff
# → n'affiche plus rien : le fichier est dans la staging area

# 4. Commiter avec un message au format type(portée): description
git commit -m "feat(chapitre-X): ajout du résumé en 5 points"

# Vérification
git log --oneline
# → 3 commits

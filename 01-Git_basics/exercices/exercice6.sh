# EXERCICE 6 : PROVOQUER ET RÉSOUDRE UN CONFLIT

# 1. Depuis main, créer titre-a et y modifier le titre du README
git switch -c titre-a
git add README.md
git commit -m "docs(readme): titre A"

# 2. Revenir sur main, créer titre-b et modifier LA MÊME ligne
git switch main
git switch -c titre-b
git add README.md
git commit -m "docs(readme): titre B"

# 3. Revenir sur main et fusionner titre-a
git switch main
git merge titre-a
# → "Fast-forward" : main n'avait pas bougé depuis la création de titre-a

# 4. Toujours sur main, fusionner titre-b
git merge titre-b
# → CONFLIT (contenu) : la ligne de titre a été modifiée des deux côtés
git status
# → README.md apparaît dans "Chemins non fusionnés"

# 5. Résoudre le conflit dans le Merge Editor (Source Control > README.md > Resolve in Merge Editor)
# 6. Finaliser le merge ("Complete Merge" puis "Continue" dans VSCode)

# 7. Afficher le graphe
git log --oneline --graph --all

# 🛟 En cas de panique au milieu du conflit, pour revenir à l'état d'avant le merge
# git merge --abort

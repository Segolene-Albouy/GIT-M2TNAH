# EXERCICE 5 : EFFECTUER UN MERGE SUR VSCODE

# 1. Dans le terminal intégré de VSCode, créer la branche biblio et s'y déplacer
git switch -c biblio

# 2. Créer biblio.md avec une référence citée dans le mémoire

# 3. Ajouter et commiter le fichier
git add biblio.md
git commit -m "feat(biblio): ajout d'une première référence"

# 4. Revenir sur main et observer l'arborescence
git switch main
ls
# → biblio.md a disparu

# 5. Sur main, remplir le README, puis commiter
git add README.md
git commit -m "docs(readme): ajout des informations du mémoire"

# 6. Afficher le graphe : les deux branches ont divergé
git log --oneline --graph --all

# 7. Revenir sur biblio et y fusionner main
git switch biblio
git merge main
# → nano s'ouvre avec le message "Merge branch 'main' into biblio" : Ctrl+S puis Ctrl+X

# 8. Revenir sur main et y fusionner biblio
git switch main
git merge biblio
# → "Fast-forward" : biblio contient déjà tout main, l'étiquette main avance simplement

# Vérification
ls
# → biblio.md est présent sur main
git log --oneline --graph --all
# → la fourche puis la réunion sont visibles

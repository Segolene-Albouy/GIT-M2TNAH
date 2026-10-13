# EXERCICE 4 : LA MACHINE À REMONTER LE TEMPS

# 1. Supprimer les points 1 et 2 du résumé

# 2. Inspecter les modifications
git status
# → chapitre-X.md est modifié
git diff
# → les points 1 et 2 apparaissent en rouge (-)

# 3. Annuler la suppression
git restore chapitre-X.md
# → les points 1 et 2 réapparaissent dans VSCode

# 4. Afficher l'historique et repérer le hash du commit de création des fiches chapitres
git log --oneline
# a1b2c3d (HEAD -> main) feat(chapitre-1): ajout du résumé en 5 points
# 4e5f6a7 feat: création des fiches chapitres     ← hash à copier
# 8b9c0d1 docs: création de la notice du mémoire

# 5. Afficher chapitre-X.md tel qu'il était dans ce commit (remplacer 4e5f6a7 par VOTRE hash)
git show 4e5f6a7:chapitre-X.md
# → la version initiale, avec les 5 points vides

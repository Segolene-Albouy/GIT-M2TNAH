# Exercice 13 : Corriger la note d'un autre groupe

# 1-2. Sur le repository de l'autre groupe : Issues > New issue
#    Titre : Le lien HAL du README renvoie une page 404
#    Description : fichier, ligne, correction proposée

# 3. Bouton Fork (en haut à droite) > Create fork
#    → copie sur son compte : <github-user>/note-de-lecture-groupe

# 4. Cloner SON fork (Code > SSH), hors de tout autre repository
cd ~/Documents
git clone git@github.com:<github-user>/note-de-lecture-groupe.git note-de-lecture-autre-groupe
code note-de-lecture-autre-groupe

# 5. Créer une branche, corriger, commiter
git switch -c fix-lien-hal
git add README.md
git commit -m "fix(readme): correction du lien HAL"

# 6. Publier la branche sur son fork
git push -u origin fix-lien-hal

# 7. Sur la page de son fork : Contribute > Open pull request
#    base repository: autre-groupe/note-de-lecture-groupe   base: main
#    head repository: <github-user>/note-de-lecture-groupe  compare: fix-lien-hal
#    Description : Fixes #N (numéro de l'issue créée à l'étape 2)
#    Create pull request

# 8. Le groupe propriétaire : Files changed > Review changes > Approve
#    puis Merge pull request (Create a merge commit) > Confirm merge

# ✅ Vérification : sur le repository de l'autre groupe, l'issue est "Closed"
#    et votre commit apparaît dans l'historique (onglet Commits)

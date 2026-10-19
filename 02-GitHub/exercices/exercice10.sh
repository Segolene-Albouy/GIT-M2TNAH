# Exercice 10 : Chacun·e sa notice, puis fusion (par groupe)

# ---------- Partie 1 : travailler en parallèle ----------

# 1. Récupérer la dernière version de main
git switch main
git pull

# 2. Créer sa branche
git switch -c notice-<prenom>

# 3. Modifier la première ligne de README.md et ajouter la ligne "Résumé : ..."

# 4. Ajouter et commiter
git add README.md
git commit -m "docs(readme): proposition de titre et de résumé"

# 5. Publier sa branche
git push
# → fatal : La branche courante notice-<prenom> n'a pas de branche amont.
git push -u origin notice-<prenom>
# → tous les push réussissent : chaque branche est indépendante,
#   le conflit n'apparaîtra qu'au moment de fusionner

# ---------- Partie 2 : relire et fusionner ----------

# 6. Lire la notice d'un·e camarade
git fetch
git branch -a
git switch notice-<prenom-camarade>
git switch notice-<prenom>

# 7. [Personne A] Fusionner sa branche dans main et publier
git switch main
git merge notice-<prenom-A>   # fast-forward
git push

# 8. [Personne B, puis C]
git switch main
git pull                      # récupère la notice de A

git switch notice-<prenom-B>
git merge main                # CONFLIT ⛔️ sur README.md

# Résoudre dans le Merge Editor (Source Control > README.md)
# → combiner les propositions, puis "Complete Merge"
git add README.md
git commit                    # Ctrl+S puis Ctrl+X

git switch main
git merge notice-<prenom-B>   # fast-forward
git push

# ✅ README.md sur GitHub sans marqueurs de conflit
git log --oneline --graph --all

# Exercice 12 : Résoudre son issue avec une PR

# PARTIE 1 : PROPOSER

# 1. Récupérer la dernière version de main
git switch main
git pull

# 2. Créer une branche nommée d'après l'issue
git switch -c biblio-commune

# 3. Réaliser la tâche (créer et remplir biblio.md dans VSCode), puis commiter
git add biblio.md
git commit -m "feat(biblio): ajout des références de la partie 2"

# 4. Se synchroniser avec la dernière version de main publiée sur GitHub
git fetch
git merge origin/main
# (en cas de conflit : Merge Editor > Complete Merge > Continue)

# 5. Publier la branche (ou Publish Branch dans VSCode)
git push -u origin biblio-commune

# 6. Sur GitHub : bandeau "Compare & pull request" (ou Pull requests > New pull request)
#    base: main <- compare: biblio-commune
#    Titre : feat(biblio): création de la bibliographie commune
#    Description : ... Closes #3
#    Reviewers : un·e camarade
#    Create pull request

# PARTIE 2 : RELIRE

# 7. Sur la PR du/de la camarade : Files changed
#    - survoler une ligne, cliquer sur + et écrire un commentaire
#    - sur une autre ligne, icône ± (Add a suggestion) et réécrire la ligne
#    - Review changes > Request changes > Submit review

# 8. Sur sa propre PR : Commit suggestion, puis récupérer ce commit en local avant de continuer
git pull
# autres corrections dans VSCode
git commit -am "fix(biblio): ajout des années manquantes"
git push

# 9. Le ou la reviewer : Review changes > Approve > Submit review

# 10. Merge pull request (Create a merge commit) > Confirm merge > Delete branch
git switch main
git pull
git branch -d biblio-commune

# Pourquoi l'issue s'est-elle fermée ? "Closes #3" dans la description de la PR, mergée dans main

# ✅ Vérification
git log --oneline --graph
# → un commit "Merge pull request #N from ..." par membre

# EXERCICE PAR DEUX

# 1. L'un des étudiants crée un repository sur GitHub et invite l'autre étudiant en tant que collaborateur

# 2. Les deux étudiants clone le repository en local
git clone <url-du-repo>

# 3. Les deux étudiants créent des modifications sur la branche main
echo "Hello world!" > hello.txt
git add hello.txt
git commit -m "Add hello.txt"

# 4. Les étudiants publient leur code sur GitHub
git pull # si besoin
git push

# 5. Après avoir mis à jour leur code en local, chaque étudiant crée une branche
git switch -c my-branch

# 6. Chaque étudiants modifient différement les mêmes fichiers
echo "Hello le monde!" > hello.txt # étudiant 1
echo "Bonjour tout le monde!" > hello.txt # étudiant 2

# 7. Les étudiants publient leur code sur GitHub
git add hello.txt
git commit -m "Update hello.txt"
git push --set-upstream origin my-branch
git push

# 8. Chaque étudiant récupère les modifications de l'autre
git fetch
git switch your-branch

# 9. Les étudiants fusionnent les modifications de l'autre
git merge my-branch

# 10. Résolution du conflit dans l'IDE

# 11. Finaliser le merge
git add hello.txt
git commit -m "Merge my-branch into your-branch"

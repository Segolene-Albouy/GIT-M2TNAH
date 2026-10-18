# Exercice 9 : Réunir sa note de lecture (par groupe)

# ---------- Partie A : mise en place ----------

# 1. [Personne A] https://github.com/new
#    Nom : note-de-lecture-groupe / cocher "Add a README file"

# 2. [Personne A] Settings > Collaborators > Add people

# 3. [Autres] Accepter l'invitation reçue par email

# 4. [Tous] Se placer EN DEHORS de note-de-lecture, puis cloner
cd ~/Documents
pwd
git clone git@github.com:<user-A>/note-de-lecture-groupe.git

# 5. [Tous] VSCode > File > Open Folder > note-de-lecture-groupe
cd note-de-lecture-groupe

# ---------- Partie B : réunir les chapitres ----------

# 6. Copier ses chapitres (ou glisser-déposer dans l'explorateur VSCode)
cp ../note-de-lecture/chapitre-*.md .

# 7. Ajouter et commiter
git status
git add chapitre-*.md
git commit -m "feat(chapitre-2): ajout du résumé du chapitre 2"

# 8. Publier
git push
# → la première personne réussit
# → les suivantes : ! [rejected] main -> main (fetch first)
#   GitHub contient des commits absents de leur main : le push n'est pas un fast-forward

# 9. Intégrer les commits publiés, puis publier
git pull
# → nano s'ouvre avec le message de merge : Ctrl+S puis Ctrl+X
git push

# ✅ tous les chapitres sont sur GitHub + commit de merge visible
git log --oneline --graph

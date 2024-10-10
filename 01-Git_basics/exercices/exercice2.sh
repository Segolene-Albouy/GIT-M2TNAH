# Création d'un repository
mkdir repository
cd repository
git init

# Création d'un fichier
echo "Hello world!" > hello.txt

# Afficher les modifications
git status
git diff

# Ajouter le fichier la staging area
git add hello.txt

# Afficher les modifications
git status

# Commiter les modifications
git commit -m "Add hello.txt"

# Afficher les modifications
git status

# Création et modification des fichiers
echo "Bonjour le monde !" > bonjour.txt
echo "Guten tag Welt!" > guten_tag.txt
echo "How are you?" >> hello.txt

# Afficher les modifications
git status
git diff

# Ajouter les fichiers à la staging area
git add bonjour.txt guten_tag.txt hello.txt

# Commiter les modifications
git commit -m "Add bonjour.txt, guten_tag.txt and update hello.txt"

# Afficher les modifications
git status

# Afficher l'historique des commits
git log

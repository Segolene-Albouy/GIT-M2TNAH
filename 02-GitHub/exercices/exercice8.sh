# Exercice 8 : Créer sa clé SSH

# 1. Créer la paire de clés (Enter pour les options par défaut)
ssh-keygen -t ed25519

# 2. Afficher la clé publique et copier toute la ligne
cat ~/.ssh/id_ed25519.pub

# 3. GitHub > Settings > SSH and GPG keys > New SSH key
#    https://github.com/settings/ssh/new
#    Coller la clé, la nommer d'après son ordinateur

# 4. Vérifier la connexion (répondre "yes" à la première connexion)
ssh -T git@github.com

# ✅ "Hi <github-user>! You've successfully authenticated, but GitHub does not provide shell access."

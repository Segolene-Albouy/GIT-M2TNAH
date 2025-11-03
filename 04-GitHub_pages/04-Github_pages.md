# Portfolio TNAH

## Déroulé de l’exercice

1. **Création d'une page personnelle** : Créer et publier votre page perso avec GitHub Pages
2. **Contribution au portfolio** : Ajouter votre profil au repository commun via un _fork_
3. **_Code review_** : Valider mutuellement vos contributions en binôme
4. **Automatisation** : Comprendre le _workflow_ GitHub Actions qui génère et déploie le portfolio

## 1. Création d'une page personnelle

Dupliquer et modifier le template [Segolene-Albouy/github-page-template](https://github.com/Segolene-Albouy/github-page-template)

1. Template : Dupliquer le template du de page personnelle
2. Username : Nommer le repository `<votre-username>.github.io`
3. Clone : Dupliquer le repository en local
4. Personnalisation : Modifier le contenu avec vos informations
5. Commit : Valider vos modifications avec un message clair
6. Push : Publier les modifications sur GitHub

### Activer les GitHub Pages

Settings > Pages > Source : `main` > Save

> **GitHub Page**
> Tout repository peut être transformé en site internet avec GitHub
> Soit le repository le fichier `index.html` (à la racine), soit le `README.md` sert de page d’accueil

## 2. Contribution au portfolio

Repository commun : [Segolene-Albouy/Portfolio-TNAH](https://github.com/Segolene-Albouy/Portfolio-TNAH)

1. Publier : Activer GitHub page sur la branche main
2. Fork : Créer un _fork_ du _repository_ du portfolio
3. Clone : Cloner le _fork_ en local
4. Commit : Ajouter vous à `students.json` **avec une erreur** 
5. Push : Pousser vos modifications sur votre _fork_ sur GitHub
6. Pull Request : Ouvrir une PR vers le repository principal

## 3. _Code review_ à plusieurs

1. Review : attribuer la tâche de review à un·e camarade
2. Comment : Signaler l’erreur commise dans votre review
3. Correction : Pusher un commit de correction du JSON depuis votre fork
4. Approval : Valider la PR si l’erreur a bien été corrigée
5. Merge : M’appeler pour achever la fusion de la PR

## 4. Automatisation avec GitHub Actions

> **GitHub Actions**
> Les actions permettent de définir des workflows automatiques sur le code du repository (test, build, etc.).
> Elles sont définies dans le dossier `.github/workflows/` sous forme de fichiers YAML

`.github/workflows/build.yml`
```yml
name: Valider et Générer le Portfolio             # nom du workflow

on:                                               # déclencheurs du workflow
  push:
    branches: [ main ]                            # lorsqu'on push sur main
  pull_request:
    branches: [ main ]                            # lorsqu'une PR est ouverte vers main

jobs:                                             # liste des jobs à exécuter
  validate-and-build:                             # Nom du job
    runs-on: ubuntu-latest                        # environnement d'exécution

    steps:
    - name: Récupérer le code                     # Nom de l'étape (sorte de git clone)
      uses: actions/checkout@v3                   # action pour récupérer le code (main par défaut)

    - name: Installer Python
      uses: actions/setup-python@v4               # action pour installer Python
      with:                                       # paramètres de l'étape
        python-version: '3.11'                    # version de Python à installer

    - name: Valider le JSON
      run: python scripts/validate_json.py        # éxecute la commande

    - name: Générer le HTML
      if: github.ref == 'refs/heads/main'         # se déclenche que sur main (pas pour une PR)
      run: python scripts/generate_html.py        # éxecute la commande

    - name: Déployer sur GitHub Pages
      if: github.ref == 'refs/heads/main'
      uses: peaceiris/actions-gh-pages@v3         # action pour déployer sur GitHub Pages
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }} # token pour commit sur le repo (fourni automatiquement par GitHub)
        publish_dir: .                            # prend le contenu du répertoire racine
        publish_branch: gh-pages                  # commit ce contenu dans la branche gh-pages

# fermeture de l'environnement d'exécution
```

Voir execution de son action : Actions > Commit > Logs

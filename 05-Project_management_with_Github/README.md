# GESTION DE PROJET SUR GITHUB

## Plan du cours

> 1. [Démarrage de projet](#démarrage-de-projet) : Comment aborder un nouveau projet
> 2. [Choix techniques](#choix-techniques) : Choisir une techno et gérer la dette technique
> 3. [Développement agile](#développement-agile) : Méthode agile et DevOps
> 4. [Exercice pratique](#exercice-pratique-mini-sprints-devops) : Mini sprint DevOps

## Démarrage de projet

> **Comment aborder un nouveau projet de développement ?**

Tout projet commence par une phase de réflexion

<hr>

### Étapes au démarrage

- 🔍 COMPRENDRE LE BESOIN
  - Qui va utiliser ?
  - Pour quoi faire ?
  - Dans quel contexte ?
- 🎯 PLANIFIER AVANT DE CODER
  - Découper en petites tâches
  - Identifier les priorités
  - Prévoir les difficultés
- ✏️ DOCUMENTER LES DÉCISIONS
  - Avoir un document de référence pour les choix à valider

<hr>

### Cahier des charges

| Vision                                               | Référence                                     | Résultat                                                      |
|------------------------------------------------------|-----------------------------------------------|---------------------------------------------------------------|
| Permet de dérouler toutes les implications du projet | Base sur laquelle discuter avec les "clients" | Permet de comparer les réalisations avec ce qui était attendu |

<hr>

### En pratique


```md
1️⃣ Lister toutes les fonctionnalités

2️⃣ Découper en petites tâches

3️⃣ Identifier les dépendances

4️⃣ (Prévoir les tests nécessaires)

5️⃣ Valider avec l'utilisateur final
```

<hr>

### Exemple : Export de données

#### Format 📊
Excel, CSV, JSON ? Structure des fichiers ?

#### Interface 💻
Page dédiée ? Bouton d'export ? Script ?

#### Contenu 📋
Quelles données inclure ? exclure ? Données personnelles ? Traçabilité ?

<hr>

## Choix techniques

### Choisir une techno

> Si on vous laisse choisir c'est que le client/manager/PI n'a pas d'avis : c'est une opportunité !
> 
> Pas de "mauvais" choix, que des compromis

<hr>

#### Les options

| Je connais déjà                                | Techno la plus répandue                             | Je veux apprendre                              |
|------------------------------------------------|-----------------------------------------------------|------------------------------------------------|
| Plus rapide à développer<br>Moins de surprises | Meilleur support communautaire & LLM bien entraînés | Plus d'inconnu mais plus intéressant pour vous |

<hr>

#### Exemple : créer un site

| **Flask**                  | **Wordpress**                     | **Svelte**               |
|----------------------------|-----------------------------------|--------------------------|
| - Rapide à mettre en place | - Très répandu                    | - Nouveau et moderne     |
| - Solution simple          | - Beaucoup de ressources en ligne | - Moins de documentation |

<hr>

### Dette technique

> Évaluer si un choix sera préjudiciable à l'avenir (e.g. Cobol)
> 
> C'est normal de réécrire du code qui a à peine 6 mois

<hr>

### C'est quoi les technos populaires ?

```md
1️⃣ Regarder les étoiles GitHub ⭐

2️⃣ Faire une recherche (Medium, etc.)

3️⃣ Demander à ChatGPT "Quelle stack pour un projet de..."
```

<hr>

## Développement agile

### L'art de planifier juste assez

| 0 plan                                    | Assez de plan                                   | Trop de plan                     |
|-------------------------------------------|-------------------------------------------------|----------------------------------|
| Chaos<br>Perte de temps<br>Zéro direction | **Flexible, rapide**<br>**Adaptation continue** | Rigide, lent<br>Décisions figées |

> ### 💡 _Le développement agile favorise l'adaptation sur la prédiction_

<hr>

### Méthode agile

#### Prioriser son travail de développement
Se concentrer sur ce qui apporte le plus de valeur

#### Ajuster la priorité des tâches au fur et à mesure
Réévaluer régulièrement ce qui est important

#### Réajuster régulièrement son plan en fonction du feedback
Être à l'écoute et s'adapter

<hr>

### DevOps = Development + Operations

> Collaboration entre développeurs et clients pour délivrer du code rapidement, de manière fiable et continue

#### 🚀 Rapide
- Livraison continue
- Feedback immédiat

#### 🐛 Bugs
- Tests automatiques
- Détection précoce des problèmes

#### 👥 Collaboration
- Communication fluide grâce à des réunions régulières

<hr>

### Les principes DevOps

```md
1️⃣ Automatiser ce qui est répétitif

2️⃣ Itérer rapidement (mini changements)

3️⃣ Collaborer en continu

4️⃣ Mesurer et s'améliorer

5️⃣ Chaque erreur est une manière d'apprendre à faire mieux
```

<hr>

### SCRUM (Version très simplifiée)

```
SPRINT (~semaine)
     ↓
Task → Pending → Doing → Done → Achieved
 ↑                                  ↓
BACKLOG                     POINT EN ÉQUIPE
```

<hr>

> 💡 **Ressources complémentaires**
> 
> - [Le Guide Scrum](https://scrumguides.org/docs/scrumguide/v2020/2020-Scrum-Guide-French.pdf)
> - [SCRUM: The Art of Doing Twice the Work in Half the Time](https://www.scruminc.com/new-scrum-the-book/)

<hr>

### Attribution des tâches

```md
1️⃣ On met dans pending les tâches les plus prioritaires

2️⃣ On ne met pas trop de tâches : rester réaliste

3️⃣ On ne fait QUE les tâches dans pending

4️⃣ Si une tâche bloque, on en prend une autre : 
   l'important c'est d'avancer, pas de suivre le plan

5️⃣ On fait un point chaque fin de sprint
```

<hr>

### Importance du feedback

#### ⚡️Rapide
- Tests automatiques
- Démonstration du code lors de réunion d'équipe

#### 👤 Intermédiaire
- Retour utilisateur
- Bug report
- Suggestions d'amélioration

#### 🌔 Long terme
- Métriques globales d'utilisation
- Retour d'expérience

<hr>

### Point entre sprints

#### 📢 Feedback
Montrer son travail et recevoir des retours (user et dev)

#### 🔄 Ajuster
Mettre à jour le backlog avec des nouvelles tâches

#### ✅ Attribuer
S'attribuer des tâches dans le backlog mis à jour

<hr>

### DevOps + GitHub

> Les **issues** GitHub peuvent être utilisées pour le suivi et l'attribution des tâches
> 
> L'**automatisation** grâce aux actions peut permettre tests et déploiement automatiques

<hr>

## Exercice pratique: Mini sprints DevOps

1. **GitHub Page personnelle**
   - Ouvrir le repository `<username>.github.io`

2. **Objectifs**
   - Identifier les besoins et souhaits pour une page perso
   - Dégager des objectifs à prioriser

3. **Backlog**
   - À partir des objectifs, découper en petites tâches
   - Créer des _issues_ GitHub pour chacune des tâches identifiées

4. **Pending**
   - S'attribuer une ou deux issues prioritaires

5. **Branche**
   - Créer une branche pour y effectuer ses développements
     ```bash
     git switch -c my-task
     ```

6. **_Sprint_** (20 minutes)
   - **Réaliser des commits relatifs aux tâches**
     ```bash
     git add .
     git commit -m "[feature] Description de la tâche"
     ```

7. **_Push_**
   - Publier la branche sur GitHub
     ```bash
     git push -u origin my-task
     ```

8. **_Pull Request_**
   - Créer une _pull request_ pour sa branche
   - Ajouter dans le titre `Close #id_issue` pour lier la PR à l'issue correspondante

9. **Point à deux**
   - Montrer vos développements effectués
   - Valider mutuellement les _Pull Requests_

10. **_Pending_**
    - S’attribuer des issues pour le prochain sprint
    - Recommencer le cycle

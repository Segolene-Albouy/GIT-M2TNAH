# Contribuer à la note de lecture

## Avant de commencer
1. Vérifier dans les issues que la tâche n’est pas déjà prise
2. Sinon, créer une issue et se l’assigner

## Branches
- partir de `main` à jour : `git switch main && git pull`
- nommer la branche `feat/<sujet>` ou `fix/<sujet>`

## Commits
- format : `type(scope): description` (`feat`, `fix`, `docs`, `refactor`, `test`)
- un commit = une modification résumable en une phrase

## Pull requests
- se synchroniser avec `origin/main` avant d’ouvrir la PR
- titre au format des commits, `Closes #N` dans la description
- 1 approbation minimum avant le merge (option « Create a merge commit »)
- supprimer la branche après le merge

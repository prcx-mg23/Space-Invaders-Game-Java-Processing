# 👾 Space Invaders - Processing Edition

Ce projet est une réinterprétation du célèbre jeu d'arcade **Space Invaders**, réalisée en Java via l'environnement **Processing**. Le joueur contrôle un vaisseau spatial et doit éliminer des vagues d'envahisseurs tout en évitant leurs tirs.
<p align="center">
  <img src="https://raw.githubusercontent.com/prcx-mg23/Space-Invaders-Game-Java-Processing/blob/main/demo/img-play.png" width="600">
</p>
##  Comment jouer ?
- **ENTRER** : Lancer le jeu depuis le menu principal.
- **Touches Q / Flèche Gauche** : Déplacer le vaisseau vers la gauche.
- **Touches D / Flèche Droite** : Déplacer le vaisseau vers la droite
- **ESPACE** : Tirer des projectiles.
- **P** : Mettre le jeu en pause ou afficher le menu.

##  Conditions de victoire et défaite
- **Victoire** : Éliminer tous les vaisseaux ennemis.
- **Défaite** : Perdre ses 3 vies ou si un envahisseur atteint votre position.

## Architecture du code (POO)
Le projet est structuré autour de plusieurs classes clés pour garantir une séparation nette des responsabilités :

- **`Board`** : Modélise le plateau de jeu sous forme de grille pour gérer le placement des objets.
- **`Spaceship`** : Gère le vaisseau du joueur (position, déplacement horizontal et affichage).
  **`Invaders`** : Représente les ennemis avec leurs propres positions et images.
- **`Game`** : Le cœur du moteur. Elle gère la logique globale, les listes d'objets (ArrayList pour les projectiles et aliens), les collisions et les scores.
- **`Menu`** : Gère l'interface utilisateur, du menu de démarrage au menu de pause.

## Détails Techniques
- **Langage** : Java / Processing.
- **Gestion des collisions** : Utilisation d' `ArrayList` pour manipuler dynamiquement les projectiles et les ennemis à l'écran.
- **Graphismes** : Intégration d'images personnalisées pour le fond (`bg_img.jpg`), le vaisseau (`spaceship.png`) et les aliens (`red_invader_2.png`).

## Limites actuelles
Certaines fonctionnalités n'ont pas encore été implémentées :
- Les positions des objets sont fixées au démarrage et ne sont pas encore lues via un fichier de niveau (`level.txt`).
- Absence de boucliers de protection pour le joueur.
- Pas de système de sauvegarde des scores.


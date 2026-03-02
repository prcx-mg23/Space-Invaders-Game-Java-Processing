class Menu {
  String title;
  String[] options = {"Recommencer le jeu", "Quitter"};  // Options du menu de pause
  int hoveredOption = -1;  // Indice de l'option survolée (-1 signifie aucune)

  // Menu principal du lancement du jeu
  void displayMainMenu() {
    background(0);  // Fond noir pour le menu principal
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Space Invaders Game", width / 2, height / 2 - 50);  // Affiche le titre du menu

    textSize(30);
    text("Press ENTER to Start", width / 2, height / 2 + 50);  // Indication pour commencer le jeu
  }

  void handleKey(int keyCode) {
    if (keyCode == ENTER) {
      startGame();  // Démarre le jeu lorsque ENTER est pressé
    }
  }

  void startGame() {
    gameStarted = true;  // Modifie l'état du jeu pour commencer
  }

  // Menu de pause pendant le jeu
  void displayPauseMenu() {
    background(50);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Pause Menu", width / 2, height / 2 - 100);

    // Affichage des options de pause
    for (int i = 0; i < options.length; i++) {
      float optionY = height / 2 - 50 + i * 40;

      // Vérifie si la souris survole l'option
      if (mouseY > optionY - 20 && mouseY < optionY + 20) {
        hoveredOption = i;
        fill(255, 204, 0); // Couleur pour l'option survolée
      } 
      else {
        fill(255); // Couleur normale
      }

      text(options[i], width / 2, optionY);
    }
  }

  // Gérer le clic pour le menu de pause
  void handleMousePressedPause( int mouseY) {
    for (int i = 0; i < options.length; i++) {
      float optionY = height / 2 - 50 + i * 40;

      if (mouseY > optionY - 20 && mouseY < optionY + 20) {
        if (i == 0) {  // "Recommencer le jeu"
          restartGame();  // Appeler la fonction de réinitialisation
        } 
        
        else if (i == 1) {  // "Quitter"
          exit();  // Quitte le jeu
        }
      }
    }
  }

  // Redémarrer le jeu
  void restartGame() {
    gameStarted = true;  // Démarre le jeu
    gamePaused = false;  // Désactive la pause
    game = new Game();  // Réinitialise le jeu
  }

  // Gérer le clic pour le menu principal (lorsque le jeu n'a pas commencé)
  void handleMousePressed( int mouseY) {
    // Vérifie si la souris clique dans la zone du bouton pour démarrer
    if (mouseY > height / 2 + 50 && mouseY < height / 2 + 80) {
      startGame();  // Démarre le jeu lorsque l'utilisateur clique
    }
  }
}

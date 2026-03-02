Game game;  // Objet pour gérer le jeu
Menu gameMenu;  // Objet pour gérer le menu
boolean gameStarted = false;  // Indicateur pour savoir si le jeu a commencé
boolean gamePaused = false;   // Indicateur pour savoir si le jeu est en pause
PImage bg_img;

void setup() {
  size(800, 800, P2D);
  game = new Game();  // Initialise le jeu
  gameMenu = new Menu();  // Initialise le menu
  bg_img=loadImage("data/bg_img.jpg");
  bg_img.resize(width, height);
}

void draw() {
  background(bg_img);  // Fond noir pour le jeu
  if (!gameStarted) {
    gameMenu.displayMainMenu();  // Affiche le menu principal si le jeu n'a pas commencé
  } 
  
  else if (gamePaused) {
    gameMenu.displayPauseMenu();  // Affiche le menu de pause si le jeu est en pause
  } 
  
  else {
    game.update();  // Met à jour l'état du jeu
    game.drawIt();  // Dessine les éléments du jeu
  }
}

void keyPressed() {
  if (!gameStarted) {
    gameMenu.handleKey(keyCode);  // Gérer les entrées de touches pour le menu de lancement
  } 
  
  else if (key == 'p') {  
    gamePaused = !gamePaused;  // Met le jeu en pause ou reprend le jeu si Échap est pressé
    return;  // Bloque le comportement par défaut de la touche ESC (fermeture de la fenêtre)
  } 
  
  else {
    game.handleKey(key);  // Gérer les entrées de touches pour le jeu
  }
}

void mousePressed() {
  if (!gameStarted) {
    gameMenu.handleMousePressed( mouseY);  // Gérer le clic pour le menu principal
  } 
  else if (gamePaused) {
    gameMenu.handleMousePressedPause( mouseY);  // Gérer le clic pour le menu de pause
  }
}

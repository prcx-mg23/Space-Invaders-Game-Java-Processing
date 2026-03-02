class Game {
  Board _board;
  Spaceship _spaceship;
  ArrayList<Invaders> _aliens;// arraylist pour les objets Invaders aliens
  ArrayList<PVector> _projectiles;// arraylist pour les projectiles de joueur
  ArrayList<PVector> _alienProjectiles;  // arraylist pour les projectiles des aliens
  String _levelName;
  int _lifes;
  int _score;
  PImage _playerImg;
  float _alienSpeedX = 1; // Vitesse horizontale
  float _alienSpeedY ;// Décalage vertical après changement de direction (descent d'une cellule du plateau de jeu) il sera initialiser à cellSize dans setup
  boolean _gameOver;
  
  // Timer pour tirer des projectiles
  float _lastShotTime = 0;  // Temps du dernier tir d'un alien
  final float _shootInterval = ALIEN_SHOOT_INTERVAL; // Intervalle de tir en millisecondes (5 secondes)

  Game() {
    _board = new Board(new PVector(width / 4, height / 4), 11, 10, 40);
    imageMode(CENTER);
    _playerImg = loadImage("data/spaceship.png");
    _spaceship = new Spaceship(_board, _playerImg, _board._cellSize * 0.5);
    _aliens = new ArrayList<Invaders>();
    _projectiles = new ArrayList<PVector>();
    _alienProjectiles = new ArrayList<PVector>(); // Initialisation des projectiles des aliens
    _score = 0;
     _alienSpeedY = _board._cellSize;// affectation de cellSize du plateau de jeu
    _lifes = START_LIFES; // Initialisation des vies
    _gameOver = false;

//positionne les aliens sur le plateau
    initializeInvaders();
  }

  void initializeInvaders() {
    for (int i = 0; i <= 2; i++) {
      for (int j = 2; j < _board._nbCellsX - 2; j++) {
        PVector position = _board.getCellCenter(i, j);
        _aliens.add(new Invaders(position));
      }
    }
  }

  void update() {
    if (_gameOver) return;

    // Vérifie si 5 secondes sont écoulées et permet aux aliens de tirer
    if (millis() - _lastShotTime > _shootInterval) {
      shootAlienProjectile();  // Un des aliens tire un projectile
      _lastShotTime = millis();  // Réinitialise le timer
    }

    moveInvaders();

    for (Invaders alien : _aliens) {
      if (dist(alien._position.x, alien._position.y, _spaceship._position.x, _spaceship._position.y) < 20) {
        _lifes--;
        if (_lifes <= 0) {
          _gameOver = true;
        }
        return;
      }
    }

    // Déplacement des projectiles (tirs) du joueur (Déplacement du projectile vers le haut)
    for (int i = _projectiles.size() - 1; i >= 0; i--) {
      PVector proj = _projectiles.get(i);
      proj.y -= 5; 
      
      if (proj.y < 0 + _board._position.x) _projectiles.remove(i);
    }

    // Déplacement des projectiles des aliens ( Déplacement des projectiles vers le bas )
    for (int i = _alienProjectiles.size() - 1; i >= 0; i--) {
      PVector alienProj = _alienProjectiles.get(i);
      alienProj.y += 2; 
      if (alienProj.y > height-_board._position.x + _board._cellSize) {
        _alienProjectiles.remove(i);
      }

      // Collision des projectiles des aliens avec le vaisseau
      if (dist(alienProj.x, alienProj.y, _spaceship._position.x, _spaceship._position.y) < 20) {
        _lifes--;
        _alienProjectiles.remove(i); // effacer le projectile après la collision
        if (_lifes <= 0) {
          _gameOver = true;
        }
      }
    }

    // Vérification des collisions entre les projectiles du joueur et les aliens
    for (int i = _aliens.size() - 1; i >= 0; i--) {
      Invaders alien = _aliens.get(i);
      for (int j = _projectiles.size() - 1; j >= 0; j--) {
        PVector proj = _projectiles.get(j);
        if (dist(alien._position.x, alien._position.y, proj.x, proj.y) < 20) {
          _aliens.remove(i);
          _projectiles.remove(j);
          _score += SCORE_KILL;
          break;
        }
      }
    }

    // Vérification de la victoire : si tous les aliens sont tués et le score atteint 210
    if (_aliens.isEmpty() && _score == 210) {
      // Affiche "YOU WIN!" sans changer _gameOver ici
      // _gameOver = true; // On ne définit pas _gameOver ici, car cela est déjà pris en compte dans le message "YOU WIN!"
    }

    // Vérification de la défaite : si les vies sont à zéro
    if (_lifes <= 0) {
      _gameOver = true;
    }
  }
  
// Déplacement des aliens sur le plateau de jeu
  void moveInvaders() {
    boolean changeDirection = false;

// vérifier si l'alien touche un bord du plateau de jeu 
    for (Invaders alien : _aliens) {
      if ((alien._position.x + 10 >= width - _board._position.x + _board._cellSize && _alienSpeedX > 0) ||
          (alien._position.x - 10 <= 0 + _board._position.x && _alienSpeedX < 0)) {
        if (alien._position.y < height - _board._position.y) {
          changeDirection = true;
          break;
        }
      }
    }

//changer de direction et descendre
    if (changeDirection) {
      _alienSpeedX *= -1;
      for (Invaders alien : _aliens) {
        alien._position.y += _alienSpeedY;
      }
    }

    for (Invaders alien : _aliens) {
      alien._position.x += _alienSpeedX;
    }
  }

  void drawIt() {
    _board.drawIt();
    _spaceship.drawIt();

    for (Invaders alien : _aliens) {
      alien.drawIt();
    }

// dessiner les projectiles du vaisseau player
    for (PVector proj : _projectiles) {
      noStroke();
      fill(0, 255, 0);
      ellipse(proj.x, proj.y, 5, 10);
    }

// dessiner les projectiles des vaisseaux aliens
    for (PVector alienProj : _alienProjectiles) {
      noStroke();
      fill(255, 0, 0);
      ellipse(alienProj.x, alienProj.y, 5, 10);
    }

// dessiner (afficher) le score et les points de vies
    fill(255);
    textSize(20);
    text("Score: " + _score, 50, height - 100);  // Affiche le score
    text("Lifes: " + _lifes, 50, height - 80);  // Affiche les vies

    // Affichage de "YOU WIN!" si tous les aliens sont tués et le score atteint 210
    if (_aliens.isEmpty() && _score == 210) {
      fill(0, 0, 0, 200);
      rectMode(CENTER);
      rect(width / 2, height / 2, width * 0.7, height * 0.2);
      fill(255);
      textSize(32);
      textAlign(CENTER, CENTER);
      text("YOU WIN!", width / 2, height / 2);
    }

    // Affichage de "GAME OVER" si les vies sont à zéro
    if (_gameOver && !(_aliens.isEmpty() && _score == 210)) {
      fill(0, 0, 0, 200);
      rectMode(CENTER);
      rect(width / 2, height / 2, width * 0.7, height * 0.2);
      fill(255);
      textSize(32);
      textAlign(CENTER, CENTER);
      text("GAME OVER", width / 2, height / 2);
    }
  }


  void handleKey(int k) {
    // déplacement du vaiisseau avec les touches du clavier
    if (k == 'q' || k == 'Q' || keyCode == LEFT) { // deplacement à gauche
      _spaceship.move(_board, new PVector(-1, 0));
    } 
    
    else if (k == 'd' || k == 'D' || keyCode == RIGHT) { // déplacement à droite
      _spaceship.move(_board, new PVector(1, 0));
    } 
    
    // créations des tirs du player avec la touche espace
    else if (k == ' ') {
      _projectiles.add(new PVector(_spaceship._position.x, _spaceship._position.y - 20));
    }
  }

  // Fonction pour tirer un projectile par les aliens
  void shootAlienProjectile() {
    if (_aliens.size() > 0) {
      // Choisir un alien aléatoire pour tirer
      int randomIndex = (int) random(_aliens.size());
      Invaders shootingAlien = _aliens.get(randomIndex);

      // Créer un projectile qui se déplace vers le bas
      PVector projectilePosition = new PVector(shootingAlien._position.x, shootingAlien._position.y + 20);
      _alienProjectiles.add(projectilePosition);
    }
  }

// class des aliens 
  class Invaders {
    PVector _position;
    PImage _invaderImg1;

    Invaders(PVector position) {
      _position = position.copy();
      _invaderImg1 = loadImage("data/red_invader_2.png");
    }

    void drawIt() {
      
        image(_invaderImg1, _position.x, _position.y);
      
    }
  }
}

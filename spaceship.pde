class Spaceship {
  // position sur l'écran
  PVector _position;
  // position sur le plateau de jeu
  int _cellX, _cellY;
  //taille du vaisseau
  float _size;
  //image
  PImage _playerImg;

// le constructeur du vaisseau 
  Spaceship(Board _board, PImage playerImg, float size) {
    _cellX = _board._nbCellsX / 2;
    _cellY = _board._nbCellsY - 1;
    _size = size;
    _playerImg = playerImg;
    update(_board);
  }
 
 // méthode qui gère les déplacements sur le plateau de jeu de cellules en cellules
  void move(Board _board, PVector dir) {
    int newCellX = _cellX + (int) dir.x;
    if (newCellX >= 0 && newCellX < _board._nbCellsX) {
      _cellX = newCellX;
      update(_board);
    }
  }

// mise à jour de la position du vaisseau
  void update(Board _board) {
    PVector cellCenter = _board.getCellCenter(_cellY, _cellX);
    _position = cellCenter.copy();
  }

// dessiner le vaisseau
  void drawIt() {
    image(_playerImg, _position.x, _position.y);
  }
}

 

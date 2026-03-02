// An enum is a special "class" that represents a group of constants.
enum TypeCell 
{
  EMPTY,
  SPACESHIP,
  INVADER,
  OBSTACLE
}

class Board 
{
  TypeCell _cells[][];
  PVector _position;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // Cells should be square.
  
  Board(PVector pos, int nbX, int nbY, int size) {
    _position = pos.copy();
    _nbCellsX = nbX;
    _nbCellsY = nbY;
    _cellSize = size;
    _cells = new TypeCell[_nbCellsY][_nbCellsX];
  }
  
  PVector getCellCenter(int i, int j) {
    return new PVector( _position.x + j * _cellSize + (_cellSize * 0.5),
                        _position.y + i * _cellSize + (_cellSize * 0.5) );
  }
  
  
  //dessiner le plateau de jeu
  void drawIt() {
     rectMode(CENTER);
     for (int i = 0; i < _nbCellsY; i++) {
      for (int j = 0; j < _nbCellsX; j++) {
        PVector cellCenter = getCellCenter(i, j); 
        fill(255,70);
        rect(cellCenter.x, cellCenter.y, _cellSize, _cellSize);
    }
  }
 }
}

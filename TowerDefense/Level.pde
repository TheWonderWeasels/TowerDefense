class Level {
  /*
 int [][] level;
 Tile[][] tiles;
 boolean useDiagonals = false;
 
 Level()
 {
  loadLevel(LevelDefs.LEVEL); 
 }
 
 void draw()
 {
   noStroke();
   for (int Y = 0; Y < tiles.length; Y++)
   {
    for (int X = 0; X < tiles[Y].length; X++)
    {
      tiles[Y][X].draw();
    }
   }
   fill(255,0,255);
 }
 
 Tile getTile(int X, int Y)
 {
  if(X < 0 || Y< 0) return null;
  if (Y >= tiles.length || X>=tiles[0].length) return null;
  return tiles[Y][X];
 }
 
 Tile getTile(Point p)
 {
  return getTile(p.x,p.y); 
 }
 
 PVector getTileCenterAt(Point p)
 {
  Tile tile = getTile(p);
  if(tile == null) return new PVector();
  return tile.getCenter();
 }
 
 boolean isPassable(Point p)
 {
  Tile tile = getTile(p);
  if(tile == null)return false;
  return tile.isPassable();
 }
 
 void reloadLevel()
 {
  loadLevel(level); 
 }
 
 void loadLevel(int[][] layout)
 {

   level = layout;
   
   int ROWS = layout.length;
   int COLS = layout[0].length;
 
   tiles = new Tile[ROWS][COLS];
      
   for(int Y = 0; Y < ROWS; Y++)
   {
    for(int X = 0; X < COLS; X++)
    {
        
     Tile tile = new Tile(X,Y);
     tile.TERRAIN = layout[Y][X];
     tiles[Y][X] = tile;
     
    }
   }
   
   // Assigning Neighbors
   for( int Y = 0; Y < ROWS; Y++)
   {
    for(int X = 0; X < COLS; X++)
    {
      tiles[Y][X].addNeighbors(new Tile[]
      {
        getTile(X-1,Y),
        getTile(X+1,Y),
        getTile(X,Y-1),
        getTile(X,Y+1)
      }
      );
      print("loading level" + X + " " + Y + "\n");
    }
   }
 
 }
 
 
}*/


  int[][] level;
  Tile[][] tiles;
  boolean useDiagonals = false;

  Level() {
    loadLevel(LevelDefs.LEVEL);
  }
  void draw() {
    noStroke();
    //if(TileHelper.isHex) rectMode(CENTER);
    for (int Y = 0; Y < tiles.length; Y++) {
      for (int X = 0; X < tiles[Y].length; X++) {
        tiles[Y][X].draw();
      }
    }
    fill(0);
  }
  Tile getTile(int X, int Y) {
    if (X < 0 || Y < 0) return null;
    if (Y >= tiles.length || X >= tiles[0].length) return null;
    return tiles[Y][X];
  }
  Tile getTile(Point p) {
    return getTile(p.x, p.y);
  }
  PVector getTileCenterAt(Point p) {
    Tile tile = getTile(p);
    if (tile == null) return new PVector();
    return tile.getCenter();
  } 
  boolean isPassable(Point p) {
    Tile tile = getTile(p);
    if (tile == null) return false;
    return tile.isPassable();
  }

  void reloadLevel() {
    loadLevel(level);
  }

  void loadLevel(int[][] layout) {

    level = layout; // cache the layout (to enable reloading levels)

    // build our multidimensional array of tiles:
    int ROWS = layout.length;
    int COLS = layout[0].length;
    tiles = new Tile[ROWS][COLS];
    for (int Y = 0; Y < ROWS; Y++) {
      for (int X = 0; X < COLS; X++) {
        Tile tile = new Tile(X, Y);
        tile.TERRAIN = layout[Y][X];
        tiles[Y][X] = tile;
      }
    }
    for (int Y = 0; Y < ROWS; Y++) {
      for (int X = 0; X < COLS; X++) {

        
          tiles[Y][X].addNeighbors(new Tile[] {
            getTile(X-1, Y), 
            getTile(X+1, Y), 
            getTile(X, Y-1), 
            getTile(X, Y+1)
          }
          );
          if (useDiagonals) {
            tiles[Y][X].addNeighbors(new Tile[] {
              getTile(X-1, Y-1), 
              getTile(X+1, Y+1), 
              getTile(X+1, Y-1), 
              getTile(X-1, Y+1)
            }
            );
          } // end if
      } // end for
    } // end for
  } // end loadLevel()

  void toggleDiagonals() {
    useDiagonals = !useDiagonals;
  }
}

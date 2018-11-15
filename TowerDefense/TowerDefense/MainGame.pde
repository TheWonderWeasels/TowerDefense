class MainGame {
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  //ArrayList<Entity> entities = new ArrayList<Entity>();

  ArrayList<Tower_Base> Towers = new ArrayList<Tower_Base>();
  //Towers array

  //Level level;
  //PathFinder pathfinder;

  PImage bg = loadImage("bg_claytons.png");

  //void setup()
  //{
  //  level = new Level();
  //  pathfinder = new PathFinder();
  //  //SpawnGrid();
  //}

  void draw()
  {
    background(bg);

    fill(255, 255, 255);
    noStroke();
    strokeWeight(0);
    rect(50, 50, 700, 700); // Play Space

    fill(210);
    rect(800, 413-25, 430, 100);
    fill(191);
    rect(800, 50, 430, 338);
    rect(800, 413, 430, 338);
    level.draw();
    Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    Tile tile = level.getTile(g);

    update();

    if (tile != null)
    {
      //spawn a tower on current grid tile when mouse is pressed
      if (mousePressed) {
        if (tile.TERRAIN != 1000) {
          Tower_Base newTower = new Tower_Base(g);
          Towers.add(newTower);
          tile.TERRAIN = 1000;//updates the pathfinding grid with the tower
          println("Tower Created" + " ");
        }
      }


      tile.hover = true;
      stroke(255, 0, 0);
      strokeWeight(3);
      noFill();
      rect(TileHelper.gridToPixel(g).x, TileHelper.gridToPixel(g).y, 50, 50);
    }
  }

  void update() {
    //updates the tower
    for (int i = 0; i < Towers.size(); i++) {
      Tower_Base tower = Towers.get(i);
      tower.draw();
    }
  }
}

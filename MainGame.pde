class MainGame {
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  //ArrayList<Entity> entities = new ArrayList<Entity>();

  //Level level;
  //PathFinder pathfinder;
  
  PImage bg = loadImage("bg_claytons.png");
  
  HUD hud;

  //void setup()
  //{
  //  level = new Level();
  //  pathfinder = new PathFinder();
  //  //SpawnGrid();
  //}

  void draw()
  {
    background(bg);
    hud = new HUD();
  
    fill(255,255,255);
    noStroke();
    strokeWeight(0);
    rect(50,50,700,700); // Play Space

    //The two HUD rects
    fill(191);
    hud.drawTop();
    hud.drawBottom();
    
    level.draw();
    Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    Tile tile = level.getTile(g);
    if(tile != null)
    {
      tile.hover = true;
      stroke(255,0,0);
      strokeWeight(3);
      noFill();
      rect(TileHelper.gridToPixel(g).x, TileHelper.gridToPixel(g).y, 50,50);
    }
  }
}

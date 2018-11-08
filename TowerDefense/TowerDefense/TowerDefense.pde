
ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<Entity> entities = new ArrayList<Entity>();
Level level;
PathFinder pathfinder;
void setup()
{
  size(1280,800);
  TileHelper.app = this;
  level = new Level();
  pathfinder = new PathFinder();
  //SpawnGrid();
}

void draw()
{
  background(194,219,208);
  
  
  fill(255,255,255);
  noStroke();
  strokeWeight(0);
  rect(50,50,700,700); // Play Space
  
  fill(210);
  rect(800,413-25, 430,100);
  fill(191);
  rect(800,50,430,338);
  rect(800,413,430,338);
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

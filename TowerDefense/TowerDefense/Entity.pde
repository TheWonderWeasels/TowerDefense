class Entity
{
  Point gridP = new Point(); // Current Position;
  Point gridT = new Point(); // target position;
  int health = 5;
  boolean isDead = false;
  PVector pixelP = new PVector();
  ArrayList<Tile> path;
  
  boolean findPath = false;
  
  Entity(Point P) 
  {
    teleportTo(P);
  }
  
  void draw()
  {
   noStroke();
   fill(0);
   ellipse(pixelP.x, pixelP.y, 25,25);
  }

  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
  
  void setTargetPosition(Point gridT)
  {
   this.gridT = gridT.get();
   findPath = true;
  }
  
  void update()
  {
   if(findPath == true) findPathAndTakeNextStep();
   if(health <=0)
   {
    isDead = true;
    return;
   }
   updateMove();
  }
  
  void findPathAndTakeNextStep()
  {
   findPath = false;
   Tile start = level.getTile(gridP);
   Tile end = level.getTile(gridT);
   if(start == end)
   {
    path = null;
    return;
   }
   path = pathfinder.findPath(start,end);
   
   if(path != null && path.size() > 1)
   {
    Tile tile = path.get(1);
    if(tile.isPassable()) gridP = new Point(tile.X, tile.Y);
   }
  }
  
  void updateMove()
  {
   float snapThreshold = 1;
   PVector pixelT = level.getTileCenterAt(gridP);
   PVector diff = PVector.sub(pixelT,pixelP);
   
   pixelP.x += diff.x * 0.2;
   pixelP.y += diff.y * 0.2;
   
   if(abs(diff.x) < snapThreshold) pixelP.x = pixelT.x;
   if(abs(diff.y) < snapThreshold) pixelP.y = pixelT.y;
   
   if(pixelT.x == pixelP.x && pixelT.y == pixelP.y) findPath = true;
  }
  
}

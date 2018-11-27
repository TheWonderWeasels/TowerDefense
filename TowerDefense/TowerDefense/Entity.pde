class Entity
{
  Point gridP = new Point(); // Current Position;
  Point gridT = new Point(); // target position;

  float disTravelled = 0;
  float speed = 1;
  float baseSpeed = 1;
  int health = 5;
  boolean isDead = false;
  PVector pixelP = new PVector();
  ArrayList<Tile> path;
  
  boolean findPath = false;
  
  Entity(Point P) 
  {
    teleportTo(P);
    findPathAndTakeNextStep();
  }
 
  void draw()
  {
    noStroke();
    fill(0);
    ellipse(pixelP.x, pixelP.y, 25, 25);
    drawPath();
  }
  /*
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
   
   if(pixelT.x == pixelP.x && pixelT.y == pixelP.y) {
     findPath = true;
     println("I am still finding");
   } else {
     //findPath = true;
      println("I am not");
   }
  }
  */
  void drawPath() {
    if (path != null && path.size() > 1) {
      stroke(0);
      PVector prevP = pixelP.get();//path.get(0).getCenter();
      for (int i = 1; i < path.size (); i++) {
        PVector currP = path.get(i).getCenter();
        line(prevP.x, prevP.y, currP.x, currP.y);
        prevP = currP;
      }
      noStroke();
      ellipse(prevP.x, prevP.y, 8, 8);
    }
  }
  
  
   void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
  void setTargetPosition(Point gridT) {
    this.gridT = gridT.get();
    findPath = true;
  }
  void update() {
    if (findPath == true) findPathAndTakeNextStep();
    updateMove();
  }
  void findPathAndTakeNextStep() {
    findPath = false;
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);
    if (start == end) {
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if (path != null && path.size() > 1) { 
      Tile tile = path.get(1);
      if(tile.isPassable()) gridP = new Point(tile.X, tile.Y);
    }
  }
  void updateMove() {
    
    float snapThreshold = .3;
    PVector pixlT = level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pixelP);
    disTravelled += diff.mag();
    println(disTravelled);
    pixelP.x += diff.x * .1 * speed;
    pixelP.y += diff.y * .1 * speed;
    
    if (abs(diff.x) < snapThreshold) pixelP.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pixelP.y = pixlT.y;

    if (pixlT.x == pixelP.x && pixlT.y == pixelP.y) findPath = true;
  }
}

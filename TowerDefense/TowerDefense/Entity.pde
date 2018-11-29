class Entity
{
  Point gridP = new Point(); // Current Position;
  Point gridT = new Point(); // target position;

  float disTravelled = 0;

  float speed = 5;
  float baseSpeed = 1;
  float radius = 25;


  int health = 5;
  int greyness = 0;
  float timeToDie = 0;
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
    ellipse(pixelP.x, pixelP.y, radius, radius);
    drawPath();
  }
  

  
  void setType(int t)
  {
   if(t == 1) // normal
   {
     speed = 2;
     health = 10;
     greyness = 100;
   }
   else if(t == 2) // fasty boi
   {
     speed = 5;
     health = 5;
     greyness = 200;
   }
   else if(t == 3) // Tank
   {
     speed = 1;
     health = 10;
     greyness = 10;
   }
  }
  
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
  
  void delayDeath()
  {
    if(timeToDie == 0)
    {
       timeToDie = millis() + 500; 
    }
  }
  void update() {
    if(timeToDie != 0)
    {
      if(millis() > timeToDie)
      {
        isDead = true;
      }
    }
    if(health <= 0)
    {
     isDead = true; 
    }
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
    pixelP.x += diff.x * .1 * speed;
    pixelP.y += diff.y * .1 * speed;
    
    if (abs(diff.x) < snapThreshold) pixelP.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pixelP.y = pixlT.y;

    if (pixlT.x == pixelP.x && pixlT.y == pixelP.y) findPath = true;
  }
}

class Entity {

  Point gridP = new Point(); // Current Position;
  Point gridT = new Point(); // target position;

  MainGame mg;
  float disTravelled = 0;

  float speed = 5;
  float baseSpeed = 1;
  float radius = 25;

  int health = 5;
  int eType = 0;
  float timeToDie = 0;
  boolean isDead = false;
  PVector pixelP = new PVector();
  ArrayList<Tile> path;
  boolean findPath = false;

  Radial radial = new Radial(radius, pixelP);
  Sprite enemyNormal, enemyBig, enemyTall;
  
  Entity(Point P) {
    teleportTo(P);
    findPathAndTakeNextStep();
  }

  void draw() {
    noStroke();
    enemyNormal.update();
    enemyTall.update();
    enemyBig.update();
    if(eType == 1) {
      enemyNormal.display(pixelP.x-25, pixelP.y-25);
    }
    if(eType == 2) {
      enemyTall.display(pixelP.x-25, pixelP.y-25);
    }
    if(eType == 3) {
      enemyBig.display(pixelP.x-25, pixelP.y-25);
    }
    drawPath();
  }

  void setType(int t) {
    enemyNormal = new Sprite("EnemyNormal_", 3);
    enemyBig = new Sprite("EnemyBig_", 3);
    enemyTall = new Sprite("EnemyTall_", 3);
    if(t == 1) { // normal
      speed = 6;
      health = 10;
      eType = 1;
    }
    else if(t == 2) { // fasty boi
      speed = 10;
      health = 5;
      eType = 2;
    }
    else if(t == 3) { // Tank
      speed = 4;
      health = 10;
      eType = 3;
    }
  }

  void drawPath() {
    if(path != null && path.size() > 1) {
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
    if(tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }

  void setTargetPosition(Point gridT) {
    this.gridT = gridT.get();
    findPath = true;
  }

  void delayDeath() {
    if(timeToDie == 0) {
      timeToDie = millis() + 500;
    }
  }

  void update() {
    if(timeToDie != 0) {
      if(millis() > timeToDie) {
        isDead = true;
      }
    }
    if(health <= 0) {
      isDead = true;
    }
    if(findPath == true) findPathAndTakeNextStep();
    updateMove();
    radial.pos = pixelP;
  }

  void findPathAndTakeNextStep() {
    findPath = false;
    Tile start = level.getTile(gridP);
    Tile end = level.getTile(gridT);
    if(start == end) {
      path = null;
      return;
    }
    path = pathfinder.findPath(start, end);

    if(path != null && path.size() > 1) {
      Tile tile = path.get(1);
      if(tile.isPassable()) gridP = new Point(tile.X, tile.Y);
      else {
        println("Path Blocked");
        if(tile.TERRAIN != 3) {
          PollutionBomb();
        }
      }
    }
  }

  void PollutionBomb() {
    // Get GridP
    // Collect all neighbors
    // Loop through the neighbors and compare their GridP to the X and Y of the tile
    // If it matches, destroy it
    // Set the TERRAIN of the tile to 4
    Tile currentTile = level.getTile(gridP);
    for(Tile t:currentTile.neighbors) {
      if(t.TERRAIN !=3) {
        t.TERRAIN = 4;
        Point p = new Point(t.X,t.Y);
        for(Tower_Base to: mg.towers) {
          if(to.gridP.compare(p)) {
            to.isDead = true;
          }
        }
      }
    }

    for(Tile t:currentTile.diagNeighbors) {
      if(t.TERRAIN != 3) {
        t.TERRAIN = 4;
        Point p = new Point(t.X,t.Y);
        for(Tower_Base to: mg.towers) {
          if(to.gridP.compare(p)) {
            to.isDead = true;
          }
        }
      }
    }
  }

  void updateMove() {

    float snapThreshold = .3;
    PVector pixlT = level.getTileCenterAt(gridP);
    PVector diff = PVector.sub(pixlT, pixelP);
    disTravelled += diff.mag();
    pixelP.x += diff.x * mg.deltaTime * speed;
    pixelP.y += diff.y * mg.deltaTime * speed;

    if (abs(diff.x) < snapThreshold) pixelP.x = pixlT.x;
    if (abs(diff.y) < snapThreshold) pixelP.y = pixlT.y;

    if (pixlT.x == pixelP.x && pixlT.y == pixelP.y) findPath = true;
  }

}

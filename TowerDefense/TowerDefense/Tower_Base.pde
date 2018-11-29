class Tower_Base {
  Point gridP = new Point(); // Current Position;
  PVector pixelP = new PVector();

  public float towerType = 1;//2 = wood, 3 = stone, 4 = wax, 5 = crystal
  public float towerLevel = 1;
  public float towerRange = 100;
  public float towerDamage = 5;
  public float towerSpeed = 1;//attacks per second
  public float towerAngle = 0;

  public float towerRotation = 0;

  public boolean selected = false;
  
  public Entity target;

  Tower_Base(Point P) {
    teleportTo(P);
  }

  void draw() {

    if (selected) {
      stroke(200);
      strokeWeight(2);
      fill(0, 0, 0, 50);
      ellipse(pixelP.x, pixelP.y, towerRange*2, towerRange*2);
    }
    if(target != null && enemyInRange(target)) aim();
    noStroke();
    fill(255);
    pushMatrix();
    translate(pixelP.x , pixelP.y);
    rotate(towerAngle - PI/2);
    rect(- (TileHelper.W/2), - (TileHelper.H/2), TileHelper.W, TileHelper.H);
    popMatrix();
  }
  void update()
  {
  }

  boolean enemyInRange(Entity enemy) {
    float towerX = pixelP.x;
    float towerY = pixelP.y;
    float enemyX = enemy.pixelP.x;
    float enemyY = enemy.pixelP.y;
    float towerR = towerRange;
    float enemyR = enemy.radius;

    float distance = sqrt( ((enemyX - towerX)*(enemyX - towerX)) + ((enemyY - towerY)*(enemyY - towerY)));

    if (distance <= towerR + enemyR) {
      println("Enemy in range");
      return true;
    } else {
      return false;
    }
  }

  void aim() {
    if (enemyInRange(target)) {
      float towerX = pixelP.x;
      float towerY = pixelP.y;
      float enemyX = target.pixelP.x;
      float enemyY = target.pixelP.y;

      float xDis = towerX - enemyX;
      float yDis = towerY - enemyY;

      towerAngle = atan2(yDis, xDis);
    }
  }

  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
}

class Tower_Base {
  MainGame mg;
  Point gridP = new Point(); // Current Position;
  PVector pixelP = new PVector();

  public int towerType = 0;//2 = wood, 3 = stone, 4 = wax, 5 = crystal
  public int towerLevel = 1;
  public float towerRange = 100;
  public float towerDamage = 5;
  public float towerSpeed = 1;//attacks per second
  public float towerAngle = 0;

  public float towerRotation = 0;

  public boolean selected = false;
  
  public Entity target;

  //tower aiming variables
  Entity lastE;//previous enemy in the array
  Entity currE;//current enemy in the array
  Entity furthestE;//enemy thats traveled the furthest
  
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
    if (mg.entities.size() != 0) {
        ArrayList<Entity> inRange = new ArrayList<Entity>();//makes a new empty array
        for (int j = 0; j < mg.entities.size(); j++) {//fills the array with all enemies in range
          if (enemyInRange(mg.entities.get(j))) {
            inRange.add(mg.entities.get(j));
          }
        }

        if (inRange.size() != 0) {
          lastE = inRange.get(0);
          furthestE = inRange.get(0);
          for (int f = 0; f < inRange.size(); f++) {//for all enemies in range, compare their distance travelled and save the one with the highest distance
            currE = inRange.get(f);
            if (currE.disTravelled > lastE.disTravelled) {
              furthestE = currE;
            }
            lastE = currE;
          }
          target = furthestE;
        }
      
    }
    println(mg.entities.size());
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

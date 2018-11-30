class Tower_Base {
  MainGame mg;
  Point gridP = new Point(); // Current Position;
  PVector pixelP = new PVector();

  public int towerType = 0; // 0 = clay, 1 = wood, 2 = stone, 3 = wax, 4 = crystal
  public int towerLevel = 1;
  public float towerRange = 100;
  public float towerDamage = 5;
  public float towerSpeed = 1;//Time Between Tower Attacks
  public float towerAngle = 0;
  public float attackTimer = 1;

  public float towerRotation = 0;
  public boolean isDead = false;
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
    attackTimerCount();
    lastE = null;//previous enemy in the array
    currE = null;//current enemy in the array
    furthestE = null;//enemy thats traveled the furthest
    target = null;
    
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
      
       if(attackTimer <= 0) {
        shoot();
        attackTimer = towerSpeed;
      }
    }
  }

 void shoot(){
    Bullets b = new Bullets();
    b.mg = mg;
    b.setStats(this.pixelP.x, this.pixelP.y, this.target.pixelP.x, this.target.pixelP.y, this.towerType);
    mg.bullets.add(b);
    //println("Pew Pew");
  }
  
   void attackTimerCount() {
    attackTimer -= mg.deltaTime;
    if (attackTimer < 0) attackTimer = 0;
  }
  
  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
}

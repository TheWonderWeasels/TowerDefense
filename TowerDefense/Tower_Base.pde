class Tower_Base {
  
  // The Towers images
  PImage clayT01 = loadImage("clay01.png");
  PImage clayT02 = loadImage("clay02.png");
  PImage clayT03 = loadImage("clay03.png");
  PImage woodT01 = loadImage("wood01.png");
  PImage woodT02 = loadImage("wood02.png");
  PImage woodT03 = loadImage("wood03.png");
  PImage stoneT01 = loadImage("stone01.png");
  PImage stoneT02 = loadImage("stone02.png");
  PImage stoneT03 = loadImage("stone03.png");
  PImage waxT01 = loadImage("wax01.png");
  PImage waxT02 = loadImage("wax02.png");
  PImage waxT03 = loadImage("wax03.png");
  PImage crystalT01 = loadImage("crystal01.png");
  PImage crystalT02 = loadImage("crystal02.png");
  PImage crystalT03 = loadImage("crystal03.png");
  
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
  public Radial radial = new Radial(towerRange, pixelP);
  
  //tower aiming variables
  Entity lastE;//previous enemy in the array
  Entity currE;//current enemy in the array
  Entity furthestE;//enemy thats traveled the furthest
  
  Tower_Base(Point P) {
    teleportTo(P);
    radial.pos = pixelP;
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
    
    // Drawing the Tower on the ground
    pushMatrix();
    translate(pixelP.x , pixelP.y);
    rotate(towerAngle - PI/2);
    if(towerType == 0) { // Clay
      if(towerLevel == 1) {
        image(clayT01, -25, -25);
      }
      else if(towerLevel == 2) {
        image(clayT02, -25, -25);
      }
      else if(towerLevel == 3) {
        image(clayT03, -25, -25);
      }
    } 
    if(towerType == 1) { // Wood
      if(towerLevel == 1) {
        image(woodT01, -25, -25);
      }
      else if(towerLevel == 2) {
        image(woodT02, -25, -25);
      }
      else if(towerLevel == 3) {
        image(woodT03, -25, -25);
      }
    }
    if(towerType == 2) { // Stone
      if(towerLevel == 1) {
        image(stoneT01, -25, -25);
      }
      else if(towerLevel == 2) {
        image(stoneT02, -25, -25);
      }
      else if(towerLevel == 3) {
        image(stoneT03, -25, -25);
      }
    }
    if(towerType == 3) { // Wax
      if(towerLevel == 1) {
        image(waxT01, -25, -25);
      }
      else if(towerLevel == 2) {
        image(waxT02, -25, -25);
      }
      else if(towerLevel == 3) {
        image(waxT03, -25, -25);
      }
    }
    if(towerType == 4) { // Crystal
      if(towerLevel == 1) {
        image(crystalT01, -25, -25);
      }
      else if(towerLevel == 2) {
        image(crystalT02, -25, -25);
      }
      else if(towerLevel == 3) {
        image(crystalT03, -25, -25);
      }
    }
    //rect(- (TileHelper.W/2), - (TileHelper.H/2), TileHelper.W, TileHelper.H);
    popMatrix();
  }
  
  void update() {
    attackTimerCount();
    lastE = null;//previous enemy in the array
    currE = null;//current enemy in the array
    furthestE = null;//enemy thats traveled the furthest
    target = null;
    
    if(mg.entities.size() != 0) {
      ArrayList<Entity> inRange = new ArrayList<Entity>();//makes a new empty array
      for (int j = 0; j < mg.entities.size(); j++) {//fills the array with all enemies in range
        if (enemyInRange(mg.entities.get(j))) {
          inRange.add(mg.entities.get(j));
        }
      }

      if(inRange.size() != 0) {
        lastE = inRange.get(0);
        furthestE = inRange.get(0);
        for(int f = 0; f < inRange.size(); f++) {//for all enemies in range, compare their distance travelled and save the one with the highest distance
          currE = inRange.get(f);
          if(currE.disTravelled > lastE.disTravelled) {
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

    //if(distance <= towerR + enemyR) {
    if(radial.CheckRadialCollision(enemy.radial))
    {
      return true;
    } 
    else {
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

  void shoot() {
    Bullets b = new Bullets();
    b.mg = mg;
    b.setStats(this.pixelP.x, this.pixelP.y, this.target.pixelP.x, this.target.pixelP.y, this.towerType, this.towerDamage);
    b.typeModifier();
    mg.bullets.add(b);
    //println("Pew Pew");
  }
  
  void attackTimerCount() {
    attackTimer -= mg.deltaTime;
    if(attackTimer < 0) attackTimer = 0;
  }
  
  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
  
  void setTowerType(int tT) {
    // Clay Tower
    if(tT == 0) {
      towerType = 0;
      towerRange = 100;
      towerDamage = 3;
      towerSpeed = 1;
      
    }
    // Wood Tower
    if(tT == 1) {
      towerType = 1;
      towerSpeed = 1.2;
      towerRange = 150;
      towerDamage = 6;
    }
    // Stone Tower
    if(tT == 2) {
      towerType = 2;
      towerSpeed = 2;
      towerRange = 75;
      towerDamage = 10;
    }
    // Wax Tower
    if(tT == 3) {
      towerType = 3;
      towerRange = 200;
      towerDamage = 1;
      towerSpeed = 1;
    }
    // Crystal Tower
    if(tT == 4) {
      towerType = 4;
      towerSpeed = 0.1;
      towerRange = 500;
      towerDamage = 0.5;
    }
    radial.radius = towerRange;
  }
  
}

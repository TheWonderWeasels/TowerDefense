class Bullets {
  MainGame mg;
  
  float bulletType = 1;//1 = clay, 2 = wood, 3 = stone, 4 = wax, 5 = crystal
  
  float bulletX = 0;
  float bulletY = 0;
  float startX = 0;
  float startY = 0;
  float targetX = 0;
  float targetY = 0;
  float bulletAngle = 0;
  
  float bulletSpeed = 500;
  PVector velocity = new PVector(0,0);
  float bXSpeed = 0;
  float bYSpeed = 0;
  
  boolean isDead = false;
  

  void draw() {
    noStroke();
    fill(0);
    ellipse(bulletX, bulletY, 5, 5);
  }

  void update() {
    bulletX += velocity.x * bulletSpeed * mg.deltaTime;
    bulletY += velocity.y * bulletSpeed * mg.deltaTime;    
    if (bulletX > 1000) isDead = true;
  }
  
  void setStats(float sX, float sY, float eX, float eY, float type){
    bulletX = sX;
    bulletY = sY;
    startX = sX;
    startY = sY;
    targetX = eX;
    targetY = eY;
    bulletAngle = atan2((eY-sY),(eX-sX));
    println(bulletAngle * PI * 180);
    velocity.x = cos(bulletAngle);
    velocity.y = sin(bulletAngle);
    
    bulletType = type;
  }
}

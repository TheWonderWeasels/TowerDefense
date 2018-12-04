class Bullets {
  MainGame mg;
  
  float bulletType = 1; // 1 = clay, 2 = wood, 3 = stone, 4 = wax, 5 = crystal
  PVector pos = new PVector();
  float startX = 0;
  float startY = 0;
  float targetX = 0;
  float targetY = 0;
  float bulletAngle = 0;
  
  float bulletSpeed = 500;
  PVector velocity = new PVector(0,0);
  float bXSpeed = 0;
  float bYSpeed = 0;
  
  float radius = 5;
  
  Radial radial = new Radial(radius, pos);
  
  boolean isDead = false;
  

  void draw() {
    noStroke();
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }

  void update() {
    pos.x += velocity.x * bulletSpeed * mg.deltaTime;
    pos.y += velocity.y * bulletSpeed * mg.deltaTime;
    radial.pos = pos;
    if (pos.x > 1000) isDead = true;
  }
  
  void setStats(float sX, float sY, float eX, float eY, float type){
    pos.x = sX;
    pos.y = sY;
    startX = sX;
    startY = sY;
    targetX = eX;
    targetY = eY;
    bulletAngle = atan2((eY-sY),(eX-sX));
    velocity.x = cos(bulletAngle);
    velocity.y = sin(bulletAngle);
    
    bulletType = type;
  }
}

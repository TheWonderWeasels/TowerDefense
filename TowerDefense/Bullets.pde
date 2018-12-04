class Bullets {
  MainGame mg;

  int bulletType = 1; // 1 = clay, 2 = wood, 3 = stone, 4 = wax, 5 = crystal
  PVector pos = new PVector();
  float startX = 0;
  float startY = 0;
  float targetX = 0;
  float targetY = 0;
  float bulletAngle = 0;
  float bulletDamage = 1;

  float bulletSpeed = 500;
  
  color bulletColor = color(0,0,0);
  PVector velocity = new PVector(0, 0);
  float bXSpeed = 0;
  float bYSpeed = 0;

  float radius = 5;

  Radial radial = new Radial(radius, pos);

  boolean isDead = false;


  void draw() {
    noStroke();
    fill(bulletColor);
    ellipse(pos.x, pos.y, 10, 10);
  }

  void update() {
    pos.x += velocity.x * bulletSpeed * mg.deltaTime;
    pos.y += velocity.y * bulletSpeed * mg.deltaTime;
    radial.pos = pos;
    if (!mg.isOnGrid(pos)) isDead = true;
  }

  void setStats(float sX, float sY, float eX, float eY, int type, float damage) {
    bulletDamage = damage;
    pos.x = sX;
    pos.y = sY;
    startX = sX;
    startY = sY;
    targetX = eX;
    targetY = eY;
    bulletAngle = atan2((eY-sY), (eX-sX));
    velocity.x = cos(bulletAngle);
    velocity.y = sin(bulletAngle);

    bulletType = type;
  }

  void typeModifier() { //type 1 = clay, type 2 = wood, type 3 = stone, type 4 = wax, type 5 = crystal

    switch (bulletType) {
    case 0:
      break;
    case 1:
      //bulletDamage += 10;
      bulletColor = color(20,193,55);
      break;
    case 2:
      //bulletDamage += 20;
       bulletColor = color(100);
      break;
    case 3:
      //bulletDamage = 0;
      bulletColor = color(225,225,140);
      break;
    case 4:
      //bulletDamage += 5;
      bulletColor = color(232,104,200);
      break;
    }
  }
}

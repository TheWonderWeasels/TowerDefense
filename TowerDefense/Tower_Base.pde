class Tower_Base {
  Point gridP = new Point(); // Current Position;
  PVector pixelP = new PVector();

  public int towerType = 0;// 0 = clay, 1 = wood, 2 = stone, 3 = wax, 4 = crystal
  public int towerLevel = 1;
  public float towerRange = 200;
  public float towerDamage = 5;
  public float towerSpeed = 1;//attacks per second
  
  public float towerRotation = 0;

  public boolean selected = false;

  Tower_Base(Point P) {
    teleportTo(P);
  }

  void draw() {

    if (selected) {
      stroke(200);
      strokeWeight(2);
      fill(0, 0, 0, 50);
      ellipse(pixelP.x, pixelP.y, towerRange, towerRange);
    }

    noStroke();
    fill(255);
    rect(pixelP.x - (TileHelper.W/2), pixelP.y - (TileHelper.H/2), TileHelper.W, TileHelper.H);
  }
  void update()
  {
    
  }
  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
}

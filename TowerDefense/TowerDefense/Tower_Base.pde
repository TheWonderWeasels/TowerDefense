class Tower_Base {
  Point gridP = new Point(); // Current Position;
  PVector pixelP = new PVector();

  Tower_Base(Point P) {
    teleportTo(P);
  }

  void draw() {
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

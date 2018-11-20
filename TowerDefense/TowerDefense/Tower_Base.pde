class Tower_Base {
  Point gridP = new Point(); // Current Position;
  PVector pixelP = new PVector();

  float range = 200;

  boolean selected = false;

  Tower_Base(Point P) {
    teleportTo(P);
  }

  void draw() {

    if (selected) {
      stroke(200);
      strokeWeight(2);
      fill(0, 0, 0, 50);
      ellipse(pixelP.x, pixelP.y, range, range);
    }

    noStroke();
    fill(255);
    rect(pixelP.x - (TileHelper.W/2), pixelP.y - (TileHelper.H/2), TileHelper.W, TileHelper.H);
  }

  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
}

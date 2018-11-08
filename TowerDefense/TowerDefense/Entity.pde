class Entity
{
  Point gridP = new Point(); // Current Position;
  Point gridT = new Point(); // target position;
  
  PVector pixelP = new PVector();
  
  void draw()
  {
   noStroke();
   fill(0);
   ellipse(pixelP.x, pixelP.y, 25,25);
  }
  
    Entity(Point P) 
  {
    teleportTo(P);
  }
  void teleportTo(Point gridP) {
    Tile tile = level.getTile(gridP);
    if (tile != null) {
      this.gridP = gridP.get();
      this.gridT = gridP.get();
      this.pixelP = tile.getCenter();
    }
  }
}

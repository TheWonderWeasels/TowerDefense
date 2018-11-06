class Tile{

  PVector pos = new PVector();  
  int size = 50;
  int TERRAIN = 1;
  boolean hover = false;
  
  Tile(int x, int y)
  {
    pos.x = x;
    pos.y = y;
  }
  
  void draw()
  {
   if(TERRAIN == 0)
     return;
   if(TERRAIN == 1) fill(200);
   if(TERRAIN == 2) fill(250);
   if(hover) fill(255,255,0);
   rect(pos.x, pos.y, size,size);
  }
}


ArrayList<Tile> tiles = new ArrayList<Tile>();

void setup()
{
  size(1280,800);
  SpawnGrid();
}

void draw()
{
  background(194,219,208);
  
  
  fill(255,255,255);
  noStroke();
  rect(50,50,700,700); // Play Space
  
  fill(210);
  rect(800,413-25, 430,100);
  fill(191);
  rect(800,50,430,338);
  rect(800,413,430,338);
  
  for(Tile tile:tiles)
  {
   tile.draw(); 
   
  }
  
}


void SpawnGrid()
{
  for(int i = 0; i < 14; i++)
  {
   for (int j =0 ; j < 14; j++)
   {
    Tile t = new Tile(i, j);
    tiles.add(t); 
   }
  }
}

class MainGame {
  ArrayList<Tile> tiles = new ArrayList<Tile>();

  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Tower_Base> towers = new ArrayList<Tower_Base>();   //Towers array

  Point mouseP;
 
  PImage bg = loadImage("bg_claytons.png");
  
  void update()
  {
    if(mousePressed)
    {
      if(mouseP != null)
      {
        if(isOnGrid())
        {
          if(mouseButton == RIGHT)
          {
           Entity e = new Entity(mouseP);
           e.setTargetPosition(new Point(0,0));
           entities.add(e);
          }
          if(mouseButton == LEFT)
          {
            Tile ti = level.getTile(mouseP);
            if(ti.TERRAIN != 2)
            {
              ti.TERRAIN = 2;
              Tower_Base t = new Tower_Base(mouseP);
              towers.add(t);
            }
          }
        }
      }
    }
    
    for(Entity e:entities)
    {
      e.update();  
    }
    for(Tower_Base t:towers)
    {
     t.update(); 
    }
  }
  
  void draw()
  {
    background(bg);

    fill(255, 255, 255);
    noStroke();
    strokeWeight(0);
    rect(50, 50, 700, 700); // Play Space

    fill(210);
    rect(800, 413-25, 430, 100);
    fill(191);
    rect(800, 50, 430, 338);
    rect(800, 413, 430, 338);
    level.draw();

    mouseP = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
    if(isOnGrid())
    {
      print(mouseP.x + " " + mouseP.y + "\n");
      Tile tile = level.getTile(mouseP);
      if(tile != null)
      {
        tile.hover = true;
        stroke(255,0,0);
        strokeWeight(3);
        noFill();
        rect(TileHelper.gridToPixel(mouseP).x, TileHelper.gridToPixel(mouseP).y, 50,50);
      }
    }
    else
      mouseP = null;
    for(Entity e :entities)
    {
      e.draw();
    }
    
    for(Tower_Base t:towers)
    {
     t.draw(); 
    }
  }
  
  boolean isOnGrid()
  {
    if(mouseX < 50) return false;
    if(mouseX > 50 * 15) return false;
    if(mouseY< 50) return false;
    if(mouseY > 50 * 15) return false;
    return true;
  }
}

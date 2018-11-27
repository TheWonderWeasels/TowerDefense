class MainGame {
  ArrayList<Tile> tiles = new ArrayList<Tile>();


  Tower_Base selectedTower;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Tower_Base> towers = new ArrayList<Tower_Base>();   //Towers array

  Point spawnPoint = new Point(14,15);
  Point goal = new Point(1,1);
  Point mouseP;
  boolean ready = false;
  float spawnTimer = millis();
  int[] currentWave = Waves.WAVES[0];
  int waveIndex = 0;
  int spawnIndex = 0;
  PImage bg = loadImage("bg_claytons.png");
  
  void update()
  {
    if(ready)
    {
      if(millis() - spawnTimer > Waves.spawnDelay)
      {
       spawnEnemy();
       spawnTimer = millis();
      }
    }
    for(Entity e:entities)
    {
      e.update();  
      if(e.gridP.compare(goal))
      {
        e.delayDeath();
      }
    }
    for(Tower_Base t:towers)
    {
     t.update(); 
    }
    
    for(int i = entities.size()-1; i >= 0; i--)
    {
      if(entities.get(i).isDead)
      {
       entities.remove(i); 
      }
    }
    if(entities.size() == 0 && spawnIndex == currentWave.length)
    {
     spawnIndex = 0;
     ready = false;
     getNextWave();
    }
    
  }
  
  void spawnEnemy()
  {
    if(currentWave != null)
    {
     if(spawnIndex < currentWave.length)
     {
       Entity e = new Entity(spawnPoint);
       e.setTargetPosition(new Point(0,0));
       e.setType(currentWave[spawnIndex]);
       entities.add(e);
       spawnIndex++;
     }
    }
  }
  
  void getNextWave()
  {
   if(waveIndex + 1 < Waves.WAVES.length -1) 
   {
     waveIndex++;
     currentWave = Waves.WAVES[waveIndex]; 
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

    for(Entity e :entities)
    {
      e.draw();
    }
    
    for(Tower_Base t:towers)
    {
     t.draw(); 
    }
    if(isOnGrid())
    {
      //print(mouseP.x + " " + mouseP.y + "\n");
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
  }
// Merge with the other spawning code

  void mouseReleased() {
    
    if(mouseP != null)
      {

        if(isOnGrid())
        {
          if(mouseButton == RIGHT)
          {
           ready = true;
          }
          if(mouseButton == LEFT) // Selecting Tile/Spawning Turret
          {
            if (selectedTower!= null)
            {
              selectedTower.selected = false;
            }
            Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
            Tile tile = level.getTile(g);
            //spawn a tower on current grid tile when mouse is pressed
            if (tile != null) {
              if (tile.TERRAIN == 2) {
                for (int i = 0; i < towers.size(); i++) {
                  Tower_Base tower = towers.get(i);
                  if (tower.gridP.x == g.x) {
                    if (tower.gridP.y == g.y) {
                      selectedTower = tower;
                      tower.selected = true;
                      println("Tower Selected");
                    }
                  } else {
                    tower.selected = false;
                  }
                }
              }
      
            if (tile.TERRAIN != 2) {
              Tower_Base newTower = new Tower_Base(g);
              towers.add(newTower);
              tile.TERRAIN = 2;//updates the pathfinding grid with the tower
              println("Tower Created" + " ");
            }
          }
        }
      }
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

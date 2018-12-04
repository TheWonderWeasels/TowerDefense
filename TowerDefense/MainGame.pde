class MainGame {
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  
  Tower_Base selectedTower;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  ArrayList<Tower_Base> towers = new ArrayList<Tower_Base>();   //Towers array
  ArrayList<Bullets> bullets = new ArrayList<Bullets>(); // bulletsArray

  Point spawnPoint = new Point(14,15);
  Point goal = new Point(1,1);
  Point mouseP;
  boolean ready = false;
  float spawnTimer = millis();
  int[] currentWave = Waves.WAVES[0];
  int waveIndex = 0;
  int spawnIndex = 0;
  PImage bg = loadImage("bg_board.png");

  float deltaTime = 0;
  float currTime = 0;
  float prevTime = 0;
  
  void reset()
  {
   entities = new ArrayList<Entity>();
   towers = new ArrayList<Tower_Base>();
   bullets = new ArrayList<Bullets>();
   ready = false;
   spawnTimer = millis();
   currentWave = Waves.WAVES[0];
   waveIndex = 0;
   spawnIndex = 0;
   deltaTime = 0;
   currTime = 0;
   prevTime = 0;
   hud.reset();
   level.loadLevel(LevelDefs.LEVEL);
   
  }
  void update() {
    getDeltaTime();
    if(ready) {
      if(millis() - spawnTimer > Waves.spawnDelay) {
       spawnEnemy();
       spawnTimer = millis();
      }
    }
    
    // Updating Things  
    for(Entity e:entities) {
      e.update();  
      if(e.gridP.compare(goal)) {
        e.delayDeath();
      }
    }
    for (Tower_Base t : towers) {
      t.update();
    }
    for(Bullets b: bullets) {
      b.update();
      if(!b.isDead)
      {
        for(Entity e: entities)
        {
          if(b.radial.CheckRadialCollision(e.radial))
          {
            b.isDead = true;
            e.health -= b.bulletDamage; // This should probably change with the other bullet types;
          }
        }
      }
    }
    
    // Removing dead things from lists
    for (int i = bullets.size()-1 ; i >= 0 ; i--){
      if(bullets.get(i).isDead) {
        bullets.remove(i);
        //println("Bullet Died");
      }
    }
    
    for (int i = towers.size()-1 ; i >= 0 ; i--){
      if(towers.get(i).isDead) {
        towers.remove(i);
        println("Bullet Died");
      }
    }
    
    for(int i = entities.size()-1; i >= 0; i--)
    {
      if(entities.get(i).isDead)
      {
       entities.remove(i); 
       hud.earn += 2;
      }
    }
    
    if(entities.size() == 0 && spawnIndex == currentWave.length)
    {
     spawnIndex = 0;
     ready = false;
     getNextWave();
    }
    
    // Losing, which currently only kicks you back to Start Menu
    if(hud.pollutionLevelCurrent >= 100) {
      gameState = 3;
    }
    
    // Winning, which would kick you back to Start Menu, if I could figure out the condition
    //if( OUR WIN CONDITION) {
    //  gameState = 4;
    //}
  }
  
  void spawnEnemy() {
    if(currentWave != null) {
      if(spawnIndex < currentWave.length) {
        Entity e = new Entity(spawnPoint);
        e.setTargetPosition(new Point(0,0));
        e.setType(currentWave[spawnIndex]);
        e.mg = this;
        e.health += waveIndex * 2;
        entities.add(e);
        spawnIndex++;
      }
    }
  }

  void getNextWave() {
   if(waveIndex + 1 < Waves.WAVES.length -1) {
     waveIndex++;
     currentWave = Waves.WAVES[waveIndex]; 
   }
   else
   {
    gameState = 4; 
   }
  }
  
  void draw() {
    background(bg);

    fill(255, 255, 255, 0);
    noStroke();
    strokeWeight(0);
    rect(50, 50, 700, 700); // Play Space

    level.draw();

    mouseP = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));

    for(Entity e : entities) {
      e.draw();
    }

    for(Tower_Base t : towers) {
      t.draw();
    }
    
    for(Bullets b : bullets) {
      b.draw();
    }
    
    if(isOnGrid()) {
      //print(mouseP.x + " " + mouseP.y + "\n");
      Tile tile = level.getTile(mouseP);
      if(tile != null) {
        tile.hover = true;
        stroke(255, 0, 0);
        strokeWeight(3);
        noFill();
        rect(TileHelper.gridToPixel(mouseP).x, TileHelper.gridToPixel(mouseP).y, 50, 50);
      }
    } 
    else {
      mouseP = null;
    }
    
  }

  void getDeltaTime() {
    currTime = millis();
    deltaTime = (currTime - prevTime)/1000;
    prevTime = currTime;
  }
 
  void mouseReleased() {
    if(mouseP != null) {
      if(isOnGrid()) {
        if(mouseButton == RIGHT) {
          ready = true;
        }
        if(mouseButton == LEFT) { // Selecting Tile/Spawning Turret
          if(selectedTower!= null) {
            selectedTower.selected = false;
            selectedTower = null;
            return;
          }
          Point g = TileHelper.pixelToGrid(new PVector(mouseX, mouseY));
          Tile tile = level.getTile(g);
          //spawn a tower on current grid tile when mouse is pressed
          if(tile != null) {
            if(tile.TERRAIN == 2) {
              for(int i = 0; i < towers.size(); i++) {
                 Tower_Base tower = towers.get(i);
                 if(tower.gridP.x == g.x) {
                   if(tower.gridP.y == g.y) {
                     selectedTower = tower;
                     tower.selected = true;
                     println("Tower Selected");
                     println(hud.towerCurrentPrice);
                   }
                 } 
                 else {
                    tower.selected = false;
                 }
              }
            }
            if(tile.TERRAIN < 2 && hud.towerCurrentType != 5) {
              if(hud.natEnergyCurrent >= hud.towerCurrentPrice) {
                Tower_Base newTower = new Tower_Base(g);
                newTower.setTowerType(hud.towerCurrentType);
                newTower.mg = this;
                towers.add(newTower);
                tile.TERRAIN = 2;//updates the pathfinding grid with the tower
                hud.buy += hud.towerCurrentPrice;
                println("Tower Created" + " ");
              }
            }
          }
        }
      }
    }
  }
  
  boolean isOnGrid() {
    if (mouseX < 50) return false;
    if (mouseX > 50 * 15) return false;
    if (mouseY< 50) return false;
    if (mouseY > 50 * 15) return false;
    return true;
  }
  
    boolean isOnGrid(PVector p) {
    if (p.x < 50) return false;
    if (p.x > 50 * 15) return false;
    if (p.y< 50) return false;
    if (p.y > 50 * 15) return false;
    return true;
  }
  
}

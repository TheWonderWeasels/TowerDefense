// Controling the game states
int gameState = 0; //The current state
final int START_MENU = 0;
final int MAIN_GAME = 1;
final int PAUSE_GAME = 2; // Not implemented yet
final int LOSE_GAME = 3;
final int WIN_GAME = 4;
final int DIFFICULTY = 5; // Not implemented yet

StartMenu sm;
MainGame mg;
LoseMenu lm;
WinMenu wm;
HUD hud;
Level level;
PathFinder pathfinder;

void setup() {
  size(1280, 800);
  sm = new StartMenu();
  mg = new MainGame();
  lm = new LoseMenu();
  wm = new WinMenu();
  hud = new HUD();
  TileHelper.app = this;
  level = new Level();
  pathfinder = new PathFinder();
}

void draw(){
  background(50);
  switch(gameState) {
    case START_MENU:
    sm.draw();
    break;
    case MAIN_GAME:
    //mg.setup();
    mg.update();
    mg.draw();
    hud.draw(mg.selectedTower);
    break;
    case PAUSE_GAME:
    
    break;
    case LOSE_GAME:
    lm.draw();
    break;
    case WIN_GAME:
    wm.draw();
    break;
  }
}

void mousePressed() {

  switch(gameState){
    case START_MENU:
    sm.mousePressed();
    break;
    case MAIN_GAME:
    hud.mousePressed();
    break;
    case PAUSE_GAME:
    
    break;
    case LOSE_GAME:
    lm.mousePressed();
    break;
    case WIN_GAME:
    wm.mousePressed();
    break;
  }
}

void mouseReleased() {
  switch(gameState)
  {
    case START_MENU:
    sm.mouseReleased();
    break;
    case MAIN_GAME:
    mg.mouseReleased();
    hud.mouseReleased(mg.selectedTower);
    break;
    case PAUSE_GAME:
    
    break;
    case LOSE_GAME:
    lm.mouseReleased();
    break;
    case WIN_GAME:
    wm.mouseReleased();
    break;
  }
}

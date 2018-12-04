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
HUD hud;
Level level;
PathFinder pathfinder;

void setup() {
  size(1280, 800);
  sm = new StartMenu();
  mg = new MainGame();
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
    sm.draw();
    break;
    case WIN_GAME:
    sm.draw();
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
    sm.mousePressed();
    break;
    case WIN_GAME:
    sm.mousePressed();
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
    sm.mouseReleased();
    break;
    case WIN_GAME:
    sm.mouseReleased();
    break;
  }
}

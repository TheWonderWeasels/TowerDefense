// Controling the game states
int gameState = 0; //The current state
final int START_MENU = 0;
final int MAIN_GAME = 1;

StartMenu sm;
MainGame mg;
Level level;
PathFinder pathfinder;

void setup() {
  size(1280, 800);
  sm = new StartMenu();
  mg = new MainGame();
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
    break;
  }
}

void mousePressed() {

  switch(gameState){
    case START_MENU:
    sm.mousePressed();
    break;
    case MAIN_GAME:
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
    break;
  }
}

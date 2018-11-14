/*
This HUD class
The top area should have the following information:
 - The amount of Nature Energy available
 - The current pollution level
 - The current round
 - The difficulty level
It's also where the player can choose which tower to put down.
 - Clay / Wood / Stone / Wax / Crystal towers

The bottom area should usually be pretty empty.  It displays information that is dependent on individual selected turrets:
 - Their name / type 
 - Their upgrade level
 - Their cost
 - Their damage
 - Their attack speed
 - Their resell value
*/


class HUD {
  
  PFont bold = createFont("Comfortaa-Bold.ttf", 64);
  PFont main = createFont("Comfortaa-Regular.ttf", 64);

  String[] difficultyLvl = {"Easy", "Medium", "Hard"};
  int natEnergyCurrent = 232;
  int pollutionLevelCurrent = 72;
  int currentRound = 10;
  int totalRounds = 50;
  
  //boolean clayHover = false;
  //boolean woodHover = false;
  //boolean stoneHover = false;
  //boolean waxHover = false;
  //boolean crystalHover = false;
  
  void drawTop() {
    fill(191);
    rect(800,50,430,338);
    fill(0);
    textAlign(LEFT, TOP);
    textFont(bold, 20);
    text("Defense of the Ancient Tree - " + difficultyLvl[1], 810, 60);
    
    textFont(main, 16);
    text("Nature Energy : " + natEnergyCurrent, 810, 90);
    text("Pollution Levels : " + pollutionLevelCurrent + "%", 810, 115);
    text("Current Round : " + currentRound + "/" + totalRounds, 810, 140);
    
    fill(255);
    rect(840, 313, 50, 50);
    rect(915, 313, 50, 50);
    rect(990, 313, 50, 50);
    rect(1065, 313, 50, 50);
    rect(1140, 313, 50, 50);

  }
  
  void drawBottom() {
    fill(191);
    rect(800,413,430,338);
  }
  
  ///* Is the mouse hovering over the button area? */
  //boolean overButton(int x, int y, int width, int height)
  //{
  //  if (mouseX >= x && mouseX <= x+width && 
  //      mouseY >= y && mouseY <= y+height) {
  //    return true;
  //  } 
  //  else {
  //  return false;
  //  }
  //}
}

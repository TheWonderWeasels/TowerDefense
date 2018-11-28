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
 There should also be an upgrade button and a sell button
*/


class HUD {

  PFont bold = createFont("Comfortaa-Bold.ttf", 64);
  PFont main = createFont("Comfortaa-Regular.ttf", 64);

  String[] difficultyLvl = {"Easy", "Medium", "Hard"};
  int natEnergyCurrent = 232;
  int pollutionLevelCurrent = 72;
  int currentRound = 10;
  int totalRounds = 50;
  String[] towerElem = {"Clay", "Wood", "Stone", "Wax", "Crystal"};
  int towerLevel = 1;

  boolean clayHover = false;
  boolean woodHover = false;
  boolean stoneHover = false;
  boolean waxHover = false;
  boolean crystalHover = false;
  color clayColor = color(255);
  color woodColor = color(255);
  color stoneColor = color(255);
  color waxColor = color(255);
  color crystalColor = color(255);
  color mouseHoverColor = color(0, 255, 0, 25);
  color mouseClickColor = color(0, 0, 255, 25);
  boolean claySelected = false;
  boolean woodSelected = false;
  boolean stoneSelected = false;
  boolean waxSelected = false;
  boolean crystalSelected = false;

  void draw(Tower_Base selectedTower) {
    noStroke();
    
    /* THE TOP AREA */
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

    // Checking where the mouse is
    update(mouseX, mouseY);

    // ClayTower Button
    if(clayHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(clayColor);
    }
    rect(840, 313, 50, 50);
    // WoodTower Button
    if(woodHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(woodColor);
    }
    rect(915, 313, 50, 50);
    // StoneTower Button
    if(stoneHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(stoneColor);
    }
    rect(990, 313, 50, 50);
    // WaxTower Button
    if(waxHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(waxColor);
    }
    rect(1065, 313, 50, 50);
    // CrystalTower Button
    if(crystalHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(crystalColor);
    }
    rect(1140, 313, 50, 50);

    /* THE BOTTOM AREA */
    fill(191);
    rect(800,413,430,338);

    fill(0);
    textAlign(LEFT, TOP);
    textFont(bold, 20);
    if (selectedTower != null && selectedTower.selected == false) {
      text(" ", 810, 423);
    }
    else if (selectedTower != null && selectedTower.selected == true) {
    text(towerElem[selectedTower.towerType] + " Tower - Level " + selectedTower.towerLevel, 810, 423);
    }
    else if (claySelected == true) {
      text(towerElem[0] + " Tower", 810, 423);
    }
    else if (woodSelected == true) {
      text(towerElem[1] + " Tower", 810, 423);
    }
    else if (stoneSelected == true) {
      text(towerElem[2] + " Tower", 810, 423);
    }
    else if (waxSelected == true) {
      text(towerElem[3] + " Tower", 810, 423);
    }
    else if (crystalSelected == true) {
      text(towerElem[4] + " Tower", 810, 423);
    }
    else {
      text(" ", 810, 423);
    }
    textFont(bold, 16);
    text("Cost", 810, 473);
    text("Resell", 1015, 473);
  }

  /* This class checks where the mouse is, with certain areas being
     triggers for a hover check */
  void update(int x, int y) {
    // ClayTower
    if (overButton(840, 313, 50, 50)) {
      clayHover = true;
      woodHover = false;
      stoneHover = false;
      waxHover = false;
      crystalHover = false;
    }
    // WoodTower
    else if (overButton(915, 313, 50, 50)) {
      clayHover = false;
      woodHover = true;
      stoneHover = false;
      waxHover = false;
      crystalHover = false;
    }
    // StoneTower
    else if (overButton(990, 313, 50, 50)) {
      clayHover = false;
      woodHover = false;
      stoneHover = true;
      waxHover = false;
      crystalHover = false;
    }
    // WaxTower
    else if (overButton(1065, 313, 50, 50)) {
      clayHover = false;
      woodHover = false;
      stoneHover = false;
      waxHover = true;
      crystalHover = false;
    }
    // CrystalTower
    else if (overButton(1140, 313, 50, 50)) {
      clayHover = false;
      woodHover = false;
      stoneHover = false;
      waxHover = false;
      crystalHover = true;
    }
    else {
      clayHover = false;
      woodHover = false;
      stoneHover = false;
      waxHover = false;
      crystalHover = false;
    }
  }

  void mousePressed() {
    if(clayHover) {
      mouseHoverColor = mouseClickColor;
      println("I pushed the clay button");
    }
    if(woodHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(stoneHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(waxHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(crystalHover) {
      mouseHoverColor = mouseClickColor;
    }
  }

  void mouseReleased() {
    mouseHoverColor = color(0, 255, 0, 25);
    // ClayTower
    if (overButton(840, 313, 50, 50)) {
      claySelected = true;
      woodSelected = false;
      stoneSelected = false;
      waxSelected = false;
      crystalSelected = false;
    }
    // WoodTower
    else if (overButton(915, 313, 50, 50)) {
      claySelected = false;
      woodSelected = true;
      stoneSelected = false;
      waxSelected = false;
      crystalSelected = false;
    }
    // StoneTower
    else if (overButton(990, 313, 50, 50)) {
      claySelected = false;
      woodSelected = false;
      stoneSelected = true;
      waxSelected = false;
      crystalSelected = false;
    }
    // WaxTower
    else if (overButton(1065, 313, 50, 50)) {
      claySelected = false;
      woodSelected = false;
      stoneSelected = false;
      waxSelected = true;
      crystalSelected = false;
    }
    // CrystalTower
    else if (overButton(1140, 313, 50, 50)) {
      claySelected = false;
      woodSelected = false;
      stoneSelected = false;
      waxSelected = false;
      crystalSelected = true;
    }
    //else {
    //  claySelected = false;
    //  woodSelected = false;
    //  stoneSelected = false;
    //  waxSelected = false;
    //  crystalSelected = false;
    //}
  }

  /* Is the mouse hovering over the button area? */
  boolean overButton(int x, int y, int width, int height)
  {
    if (mouseX >= x && mouseX <= x+width &&
        mouseY >= y && mouseY <= y+height) {
      return true;
    }
    else {
    return false;
    }
  }
}

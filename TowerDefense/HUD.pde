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
  int natEnergyCurrent = 0;
  int pollutionLevelCurrent = 0;
  int currentRound = 0;
  int totalRounds = 30;
  String[] towerElem = {"Clay", "Wood", "Stone", "Wax", "Crystal"};

  PImage clayIcon = loadImage("clay01.png");
  PImage woodIcon = loadImage("wood01.png");
  PImage stoneIcon = loadImage("stone01.png");
  PImage waxIcon = loadImage("wax01.png");
  PImage crystalIcon = loadImage("crystal01.png");
  boolean clayHover = false;
  boolean woodHover = false;
  boolean stoneHover = false;
  boolean waxHover = false;
  boolean crystalHover = false;
  color clayColor = color(255, 0);
  color woodColor = color(255, 0);
  color stoneColor = color(255, 0);
  color waxColor = color(255, 0);
  color crystalColor = color(255, 0);
  color mouseHoverColor = color(0, 255, 0, 25);
  color mouseClickColor = color(0, 0, 255, 25);
  boolean claySelected = false;
  boolean woodSelected = false;
  boolean stoneSelected = false;
  boolean waxSelected = false;
  boolean crystalSelected = false;
  
  int clayBasePrice = 10;
  float clayDamage = 5;
  float claySpeed = 1;
  float clayRange = 200;
  int woodBasePrice = 50;
  float woodDamage = 10;
  float woodSpeed = 2;
  float woodRange = 150;
  int stoneBasePrice = 100;
  float stoneDamage = 15;
  float stoneSpeed = 1;
  float stoneRange = 250;
  int waxBasePrice = 150;
  float waxDamage = 0;
  float waxSpeed = 5;
  float waxRange = 50;
  int crystalBasePrice = 500;
  float crystalDamage = 50;
  float crystalSpeed = 10;
  float crystalRange = 500;

  void draw(Tower_Base selectedTower) {
    noStroke();
    
    /* THE TOP AREA */
    fill(196, 221, 210);
    rect(800,50,430,338);
    
    fill(1, 16, 27);
    textAlign(LEFT, TOP);
    textFont(bold, 20);
    text("Defense of the Ancient Tree - " + difficultyLvl[0], 810, 60);

    textFont(main, 16);
    text("Nature Energy : " + natEnergyCurrent, 810, 100);
    text("Pollution Levels : " + pollutionLevelCurrent + "%", 810, 125);
    text("Current Round : " + currentRound + "/" + totalRounds, 810, 150);

    // Checking where the mouse is
    update(mouseX, mouseY);

    // ClayTower Button
    if(clayHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(clayColor);
    }
    image(clayIcon, 840, 313);
    rect(840, 313, 50, 50);
    
    // WoodTower Button
    if(woodHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(woodColor);
    }
    image(woodIcon, 915, 313);
    rect(915, 313, 50, 50);
    
    // StoneTower Button
    if(stoneHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(stoneColor);
    }
    image(stoneIcon, 990, 313);
    rect(990, 313, 50, 50);
    
    // WaxTower Button
    if(waxHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(waxColor);
    }
    image(waxIcon, 1065, 313);
    rect(1065, 313, 50, 50);
    
    // CrystalTower Button
    if(crystalHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(crystalColor);
    }
    image(crystalIcon, 1140, 313);
    rect(1140, 313, 50, 50);

    /* THE BOTTOM AREA */
    fill(196, 221, 210);
    rect(800,413,430,338);

    fill(1, 16, 27);
    textAlign(LEFT, TOP);
    textFont(bold, 20);
    if (selectedTower != null && selectedTower.selected == true) {
      text(towerElem[selectedTower.towerType] + " Tower - Level " + selectedTower.towerLevel, 810, 423);
      // Titles
      textFont(bold, 16);
      text("Current", 915, 473);
      text("Next Level", 1065, 473);
      textAlign(CENTER, TOP);
      text("Sell [" + "CREATEPRICE" + "]", 1015, 625);
      text("Upgrade [" + "IDK" + "]", 1015, 675);
      // Stats
      textAlign(LEFT, TOP);
      textFont(main, 16);
      text("Damage:", 810, 503);
      text("Speed:", 810, 533);
      text("Range:", 810, 563);
      text(int(selectedTower.towerDamage), 915, 503);
      text(int(selectedTower.towerDamage)*5, 1065, 503);
      text(int(selectedTower.towerSpeed), 915, 533);
      text(int(selectedTower.towerSpeed)*5, 1065, 533);
      text(int(selectedTower.towerRange), 915, 563);
      text(int(selectedTower.towerRange)*5, 1065, 563);
    }
    else if (claySelected == true) {
      text(towerElem[0] + " Tower", 810, 423);
      // Titles
      textFont(bold, 16);
      text("Current", 915, 473);
      text("Next Level", 1065, 473);
      textAlign(CENTER, TOP);
      text("Cost [" + clayBasePrice + "]", 1015, 625);
      // Stats
      textAlign(LEFT, TOP);
      textFont(main, 16);
      text("Damage:", 810, 503);
      text("Speed:", 810, 533);
      text("Range:", 810, 563);
      text(int(clayDamage), 915, 503);
      text(int(clayDamage)*5, 1065, 503);
      text(int(claySpeed), 915, 533);
      text(int(claySpeed)*5, 1065, 533);
      text(int(clayRange), 915, 563);
      text(int(clayRange)*5, 1065, 563);
    }
    else if (woodSelected == true) {
      text(towerElem[1] + " Tower", 810, 423);
      // Titles
      textFont(bold, 16);
      text("Current", 915, 473);
      text("Next Level", 1065, 473);
      textAlign(CENTER, TOP);
      text("Cost [" + woodBasePrice + "]", 1015, 625);
      // Stats
      textAlign(LEFT, TOP);
      textFont(main, 16);
      text("Damage:", 810, 503);
      text("Speed:", 810, 533);
      text("Range:", 810, 563);
      text(int(woodDamage), 915, 503);
      text(int(woodDamage)*5, 1065, 503);
      text(int(woodSpeed), 915, 533);
      text(int(woodSpeed)*5, 1065, 533);
      text(int(woodRange), 915, 563);
      text(int(woodRange)*5, 1065, 563);
    }
    else if (stoneSelected == true) {
      text(towerElem[2] + " Tower", 810, 423);
      // Titles
      textFont(bold, 16);
      text("Current", 915, 473);
      text("Next Level", 1065, 473);
      textAlign(CENTER, TOP);
      text("Cost [" + stoneBasePrice + "]", 1015, 625);
      // Stats
      textAlign(LEFT, TOP);
      textFont(main, 16);
      text("Damage:", 810, 503);
      text("Speed:", 810, 533);
      text("Range:", 810, 563);
      text(int(stoneDamage), 915, 503);
      text(int(stoneDamage)*5, 1065, 503);
      text(int(stoneSpeed), 915, 533);
      text(int(stoneSpeed)*5, 1065, 533);
      text(int(stoneRange), 915, 563);
      text(int(stoneRange)*5, 1065, 563);
    }
    else if (waxSelected == true) {
      text(towerElem[3] + " Tower", 810, 423);
      // Titles
      textFont(bold, 16);
      text("Current", 915, 473);
      text("Next Level", 1065, 473);
      textAlign(CENTER, TOP);
      text("Cost [" + waxBasePrice + "]", 1015, 625);
      // Stats
      textAlign(LEFT, TOP);
      textFont(main, 16);
      text("Damage:", 810, 503);
      text("Speed:", 810, 533);
      text("Range:", 810, 563);
      text(int(waxDamage), 915, 503);
      text(int(waxDamage)*5, 1065, 503);
      text(int(waxSpeed), 915, 533);
      text(int(waxSpeed)*5, 1065, 533);
      text(int(waxRange), 915, 563);
      text(int(waxRange)*5, 1065, 563);
    }
    else if (crystalSelected == true) {
      text(towerElem[4] + " Tower", 810, 423);
      // Titles
      textFont(bold, 16);
      text("Current", 915, 473);
      text("Next Level", 1065, 473);
      textAlign(CENTER, TOP);
      text("Cost [" + crystalBasePrice + "]", 1015, 625);
      // Stats
      textAlign(LEFT, TOP);
      textFont(main, 16);
      text("Damage:", 810, 503);
      text("Speed:", 810, 533);
      text("Range:", 810, 563);
      text(int(crystalDamage), 915, 503);
      text(int(crystalDamage)*5, 1065, 503);
      text(int(crystalSpeed), 915, 533);
      text(int(crystalSpeed)*5, 1065, 533);
      text(int(crystalRange), 915, 563);
      text(int(crystalRange)*5, 1065, 563);
    }
    else {
      text(" ", 810, 423);
    }
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

/*
The game start menu is the first thing the player sees.
It needs:
 - Start Game (sends the player to the main game loop)
 - Load Game (not sure if we're implementing that yet)
 - View controls (an image overlay, dismissed when clicked on)
 - Quit (closes the game)
 - A music on/off button
 - A SFX on/off button
*/

class StartMenu {
  PImage bg = loadImage("bg_claytons.png");
  PImage bgStart = loadImage("bgStart.png");
  PImage title = loadImage("title.png");
  PImage start = loadImage("start.png");
  PImage load = loadImage("load.png");
  PImage controls = loadImage("controls.png");
  PImage quit = loadImage("quit.png");
  PImage music = loadImage("music.png");
  PImage SFX = loadImage("SFX.png");
  
  boolean SGB_mouseHover = false;
  boolean LGB_mouseHover = false;
  boolean QGB_mouseHover = false;
  boolean VCB_mouseHover = false;
  boolean MOOB_mouseHover = false;
  boolean SFXOOB_mouseHover = false;
  color SGB_Color = color(255, 0, 255, 0);
  color LGB_Color = color(255, 0, 255, 0);
  color QGB_Color = color(255, 0, 255, 0); 
  color VCB_Color = color(255, 0, 255, 0);
  color MOOB_Color = color(255, 0, 255, 0);
  color SFXOOB_Color = color(255, 0, 255, 0);
  color mouseHoverColor = color(0, 255, 0, 25);
  color mouseClickColor = color(0, 0, 255, 25);
  
  PImage controlsImage = loadImage("controlsImage.png");
  boolean controlsVisible = false;
  
  void draw() {
    // Checking where the mouse is
    update(mouseX, mouseY);
    
    // Background Visuals
    background(bg);
    image(title, 266, 43);
    
    // Start Game Button
    if(SGB_mouseHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(SGB_Color);
    }
    image(start, 438, 277);
    rect(438, 277, 314, 135);
    
    // Load Game Button
    if(LGB_mouseHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(LGB_Color);
    }
    image(load, 439, 418);
    rect(439, 418, 312, 131);
    
    // Quit Game Button
    if(QGB_mouseHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(QGB_Color);
    }
    image(quit, 18, 647);
    rect(18, 647, 210, 130);
    
    // View Controls Button
    if(VCB_mouseHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(VCB_Color);
    }
    image(controls, 441, 555);
    rect(441, 555, 312, 136);
    
    // Music On/Off Button
    if(MOOB_mouseHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(MOOB_Color);
    }
    image(music, 1127, 642);
    rect(1127, 642, 137, 114);
    
    // SFX On/Off Button
    if(SFXOOB_mouseHover) {
      fill(mouseHoverColor);
    }
    else {
      fill(SFXOOB_Color);
    }
    image(SFX, 1123, 519);
    rect(1123, 519, 142, 114);

    control(controlsVisible);
  }
  
  /* This class checks where the mouse is, with certain areas being
     triggers for a hover check */
  void update(int x, int y) {
    // Start Game Button
    if (overButton(438, 277, 314, 135)) {
      SGB_mouseHover = true;
      LGB_mouseHover = false;
      QGB_mouseHover = false;
      VCB_mouseHover = false;
      MOOB_mouseHover = false;
      SFXOOB_mouseHover = false;
    } 
    // Load Game Button
    else if ( overButton(439, 418, 312, 131)) {
      SGB_mouseHover = false;
      LGB_mouseHover = true;
      QGB_mouseHover = false;
      VCB_mouseHover = false;
      MOOB_mouseHover = false;
      SFXOOB_mouseHover = false;
    } 
    // Quit Game Button
    else if (overButton(18, 647, 210, 130)) {
      SGB_mouseHover = false;
      LGB_mouseHover = false;
      QGB_mouseHover = true;
      VCB_mouseHover = false;
      MOOB_mouseHover = false;
      SFXOOB_mouseHover = false;
    } 
    // View Controls Button
    else if (overButton(441, 555, 312, 136)) {
      SGB_mouseHover = false;
      LGB_mouseHover = false;
      QGB_mouseHover = false;
      VCB_mouseHover = true;
      MOOB_mouseHover = false;
      SFXOOB_mouseHover = false;
    } 
    // Music On/Off Button
    else if (overButton(1127, 642, 137, 114)) {
      SGB_mouseHover = false;
      LGB_mouseHover = false;
      QGB_mouseHover = false;
      VCB_mouseHover = false;
      MOOB_mouseHover = true;
      SFXOOB_mouseHover = false;
    }
    // SFX On/Off Button
    else if (overButton(1123, 519, 142, 114)) {
      SGB_mouseHover = false;
      LGB_mouseHover = false;
      QGB_mouseHover = false;
      VCB_mouseHover = false;
      MOOB_mouseHover = false;
      SFXOOB_mouseHover = true;
    } 
    // No Button
    else {
      SGB_mouseHover = false;
      LGB_mouseHover = false;
      QGB_mouseHover = false;
      VCB_mouseHover = false;
      MOOB_mouseHover = false;
      SFXOOB_mouseHover = false;
    }
  }
  
  /* Pressing the mouse changes the hover color to the mouse click color */
  void mousePressed() {
    if(SGB_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(LGB_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(QGB_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(VCB_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(MOOB_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(SFXOOB_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(controlsVisible == true) {
      controlsVisible = false;
    };
  }
  
  /* Resetting the hover color, and triggering relevant actions */
  void mouseReleased() {
      mouseHoverColor = color(0, 255, 0, 25);
      // Start a Game
      if(overButton(438, 277, 314, 135)) {
        gameState = 1;
      }
      // Show Controls
      if(overButton(441, 555, 312, 136)) {
        controlsVisible = true;
      }
      // Exit Game
      if(overButton(18, 647, 210, 130)) {
        exit();
      }
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
  
  /* Is the controls pop-up visible? If so, show the image*/
  void control(boolean visible) {
    if(visible) {
      image(controlsImage, 50, 50);
    }
  }

}

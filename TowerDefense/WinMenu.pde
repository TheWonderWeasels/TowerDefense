/* The win screen */

class WinMenu {
  
  PImage bg = loadImage("win.png");
  PImage tryA_w = loadImage("tryA_w.png");
  PImage mainM_w = loadImage("mainM_w.png");
  
  boolean Restart_mouseHover = false;
  boolean SM_mouseHover = false;
  color Restart_Color = color(255, 0, 255, 0);
  color SM_Color = color(255, 0, 255, 0);
  color mouseHoverColor = color(0, 255, 0, 0);
  color mouseClickColor = color(0, 0, 255, 0);
  
  void draw() {
    
    // Checking where the mouse is
    update(mouseX, mouseY);
    
    // Background Visuals
    background(bg);
    noStroke();
    
    // Restart Game Button
    if(Restart_mouseHover) {
      fill(mouseHoverColor);
      pushMatrix();
      translate(352+(380/2), 376+(100/2));
      scale(1.05);
      image(tryA_w, -(380/2), -(100/2));
      popMatrix();
      rect(352, 376, 380, 100);
    }
    else {
      fill(Restart_Color);
    }
    if(!Restart_mouseHover) {
      image(tryA_w, 352, 376);
      rect(352, 376, 380, 100);
    }
    
    // Main Menu Button
    if(SM_mouseHover) {
      fill(mouseHoverColor);
      pushMatrix();
      translate(352+(380/2), 502+(100/2));
      scale(1.05);
      image(mainM_w, -(380/2), -(100/2));
      popMatrix();
      rect(352, 502, 380, 100);
    }
    else {
      fill(SM_Color);
    }
    if(!SM_mouseHover) {
      image(mainM_w, 352, 502);
      rect(352, 502, 380, 100);
    }
  }
  
  /* This class checks where the mouse is, with certain areas being
     triggers for a hover check */
  void update(int x, int y) {
    // Restart Game Button
    if (overButton(352, 376, 380, 100)) {
      Restart_mouseHover = true;
      SM_mouseHover = false;
    } 
    // Main Menu Button
    else if (overButton(352, 502, 380, 100)) {
      Restart_mouseHover = false;
      SM_mouseHover = true;
    } 
    // No Button
    else {
      Restart_mouseHover = false;
      SM_mouseHover = false;
    }
  }
  
  /* Pressing the mouse changes the hover color to the mouse click color */
  void mousePressed() {
    if(Restart_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
    if(SM_mouseHover) {
      mouseHoverColor = mouseClickColor;
    }
  }
  
  /* Resetting the hover color, and triggering relevant actions */
  void mouseReleased() {
    mouseHoverColor = color(0, 255, 0, 25);
    // Restart Game
    if(overButton(352, 376, 380, 100)) {
      gameState = 1;
      mg.reset();
    }
    // Back to Main Menu
    if(overButton(352, 502, 380, 100)) {
      gameState = 0;
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

}

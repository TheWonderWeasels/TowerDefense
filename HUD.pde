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
  
  void drawTop() {
    rect(800,50,430,338);
  }
  
  void drawBottom() {
    rect(800,413,430,338);
  }
}

/* The sprite animation class */

class Sprite {
  PImage[] images;
  int imageCount;
  int frame;
  int counter = 0;
 
  Sprite(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  void update() {
    counter++;
    if(counter >= 6) {
      frame++;
      if(frame >= 3) {
        frame = 0;
      }
      counter = 0;
    }
  }
  
  void display(float xpos, float ypos) {
    image(images[frame], xpos, ypos);
  }
  
}

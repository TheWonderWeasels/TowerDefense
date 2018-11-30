/* The sprite animation class */

class Sprite {
  PImage[] images;
  int imageCount;
  int frame;
 
  Sprite(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];
    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }
  
  void display() {
    frame = (frame+1) % 3;
    image(images[frame], -25, -25);
  }
  
}

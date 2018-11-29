class Point {
  int x = 0;
  int y = 0;
  Point(){ }
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  boolean compare(Point p)
  {
   if(p.x == this.x && p.y == this.y) return true;
   return false;
  }
  Point get(){
    return new Point(x, y); 
  }
  Point getUp(){
    return new Point(x, y-1);
  }
  Point getDown(){
    return new Point(x, y+1);
  }
  Point getLeft(){
    return new Point(x-1, y);
  }
  Point getRight(){
    return new Point(x+1, y);
  }
  String toString(){
    return x + ", " + y; 
  }
}

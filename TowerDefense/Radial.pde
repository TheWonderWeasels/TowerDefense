class Radial {
  float radius = 0;
  PVector pos = new PVector();
  
  public Radial(float r, PVector p)
  {
   radius = r;
   pos = p;
  }
  
  public boolean CheckRadialCollision(Radial r)
  {
    if(pos.dist(r.pos) < (radius + r.radius))
    {
     return true; 
    }
    return false;
  }
  
}

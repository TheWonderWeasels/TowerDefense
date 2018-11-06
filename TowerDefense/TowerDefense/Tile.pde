
static class TileHelper {

  static TowerDefense app;
  final static int W = 50;
  final static int H = 50;
  final static int halfW = W / 2;
  final static int halfH = H / 2;

  static PVector gridToPixel(Point p) {
    return gridToPixel(p.x, p.y);
  }
  static PVector gridToPixel(int X, int Y){
    PVector v = new PVector((X * W) + 50, (Y * H)+ 50) ;
    return v;
  }
  static Point pixelToGrid(PVector v) {

    int x = (int)((v.x - 50) / W);
    int y = (int)((v.y -50) / H);    
    return app.new Point(x, y);
  }
}


class Tile{

  int X;
  int Y;
  
  int TERRAIN = 1;
  boolean hover = false;
  
  Tile(int x, int y)
  {
    X = x;
    Y = y;
  }
  
  void draw()
  {
   if(TERRAIN == 0)
     return;
   if(TERRAIN == 1) fill(200,100,50);
   if(TERRAIN == 2) fill(250);
   if(hover) fill(255,255,0);
   PVector p = TileHelper.gridToPixel(X,Y);
   rect(p.x, p.y, TileHelper.W,TileHelper.H);
  }
  
  PVector GetCenter()
  {
    PVector p = TileHelper.gridToPixel(new Point(X,Y));
    p.x += TileHelper.halfW;
    p.y += TileHelper.halfH;
    return p;
  }
  
  
  /////PATHFINDING JANK
  
  ArrayList<Tile> neighbors = new ArrayList<Tile>();
  Tile parent;
  float G;
  float F;
  
  void addNeighbors(Tile[] tiles)
  {
   for (Tile t:tiles)
   {
    if(t != null) neighbors.add(t); 
   }
  }
  
  void setParent(Tile n)
  {
   parent = n;
   G = parent.G + getTerrainCost();
  }
  
  
  void resetParent()
  {
   parent = null;
   G = 0;
   F = 0;
  }
  
  float getTerrainCost()
  {
   return 0; 
  }
  
  
  void doHeuristic(Tile n)
  {
   F = G + distanceEuclidean(n); 
  }
  
  float distanceEuclidean(Tile n)
  {
   float dx = n.X - X;
   float dy = n.Y - Y;
   
   return sqrt(dx *dx + dy * dy);
  }
}

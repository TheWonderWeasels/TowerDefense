
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
    PVector v = new PVector((X * W), (Y * H)) ;
    return v;
  }
  static Point pixelToGrid(PVector v) {

    int x = (int)((v.x) / W);
    int y = (int)((v.y) / H);    
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

   if(TERRAIN == 0) fill(200,100,50);
   if(TERRAIN == 1) fill(200,100,50);
   if(TERRAIN == 2) fill(130);
   if(TERRAIN == 3) noFill();
   //if(hover)fill(255,255,0); 
  
   PVector p = TileHelper.gridToPixel(X,Y);
   rect(p.x, p.y, TileHelper.W,TileHelper.H);
   hover = false;
  }
  
  PVector getCenter()
  {
    PVector p = TileHelper.gridToPixel(new Point(X,Y));
    p.x += TileHelper.halfW;
    p.y += TileHelper.halfH;
    return p;
  }
  
  boolean isPassable(){
    return (TERRAIN != 2 && TERRAIN != 3); 
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
   if (TERRAIN >= 0 && TERRAIN < LevelDefs.MOVECOST.length) return LevelDefs.MOVECOST[TERRAIN];
   return 0; 
  }
  
  
 void doHeuristic(Tile n, boolean useManhattan) {
    if (useManhattan) F = G + distanceManhattan(n);
    if (!useManhattan) F = G + distanceEuclidean(n);
  }
  
  float distanceManhattan(Tile n) {
    return abs(n.X - X) + abs(n.Y - Y);
  }
  
  float distanceEuclidean(Tile n)
  {
   float dx = n.X - X;
   float dy = n.Y - Y;
   
   return sqrt(dx *dx + dy * dy);
  }
}

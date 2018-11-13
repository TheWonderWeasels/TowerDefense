class PathFinder
{
 ArrayList<Tile> open = new ArrayList<Tile>();  // Tiles use in the algorithm
 ArrayList<Tile> closed = new ArrayList<Tile>(); // tiles ruled to not be in the solution
 
 PathFinder()
 {
   
 }
 
 
 ArrayList<Tile> findPath(Tile start, Tile end)
 {
  open.clear();
  closed.clear();
  
  start.resetParent();
  
  //Step 1:
  connectStartToEnd(start,end);
  
  //Setp 2: Build Path From Begining;
  ArrayList<Tile> path = new ArrayList<Tile>();
  Tile pathNode = end;
  while(pathNode != null)
  {
   path.add(pathNode);
   pathNode = pathNode.parent;
  }
  
  // Step 3: Reverse Collection
  ArrayList<Tile> rev = new ArrayList<Tile>();
  int maxIndex = path.size() -1;
  for(int i = maxIndex; i >=0; i--)
  {
    rev.add(path.get(i));
  }
  return rev;
 }
 
 void connectStartToEnd(Tile start, Tile end)
 {
  open.add(start);
  
  while(open.size() > 0)
  {
   // Find lowest F value nod in Open
   float F = 9999;
   int index = -1;
   for(int i = 0; i < open.size(); i++)
   {
     Tile temp = open.get(i);
     if(temp.F < F)
     {
      F = temp.F;
      index = i;
     }
   }
   
   Tile current = open.remove(index);
   closed.add(current);
   
   
   if(current == end)
   {  
     // Found the path;
     break;
   }
   // Loop Through Neighbors of the current tile
   
   for(int i = 0; i < current.neighbors.size(); i++)
   {
    Tile neighbor = current.neighbors.get(i);
    if(!tileInArray(closed, neighbor))
    {
     if(!tileInArray(open, neighbor))
     {
      open.add(neighbor);
      neighbor.setParent(current);
      neighbor.doHeuristic(end);
     }
     else
     {
      if(neighbor.G > current.G + neighbor.getTerrainCost())
      {
       neighbor.setParent(current);
       neighbor.doHeuristic(end);
      }
     }
    }
   }
  }
 }
 
 boolean tileInArray(ArrayList<Tile> a, Tile t)
 {
   for (int i = 0; i < a.size(); i++)
   {
    if(a.get(i) == t) return true; 
   }
   return false;
 }
 
} // End of class

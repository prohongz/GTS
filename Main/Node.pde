class Node
{
  ArrayList<PVector> points;
  ArrayList<ArrayList<Integer>> nextlink = new ArrayList<ArrayList<Integer>>();
  float radius;
  ArrayList<Boolean> Occupy = new ArrayList<Boolean>();

  int nodecount = 0;

  void Path()
  {
    radius = 25;
    points = new ArrayList <PVector>();
  }

  //Setting NODE XY Coordinate
  void addPoint(float x, float y)
  {
    PVector point = new PVector(x, y);
    points.add(point);
  }

  //Setting NODE linkage
  void addlink(int currentnode, int nextnode)
  {
    if (currentnode > nodecount)
    { 
      nodecount++;
      nextlink.add(new ArrayList<Integer>());
      //print(nodecount, " ");
    }
    nextlink.get(currentnode-1).add(nextnode);
    
    //FOR TESTING
    //print("\ncurrent node: ", currentnode, "\n");
    //print("next node: ", nextnode, "\n\n");
  }
  
  void display()
  {
    stroke(0);
    noFill();
    beginShape();
    int i=1;
    for (PVector v : points)
    {
      fill(0);
      textSize(10);
      text(i, v.x, v.y);
      i++;
      noFill();
      ellipse(v.x, v.y, radius, radius); // Change for circle size
    }
    endShape();
  }
}

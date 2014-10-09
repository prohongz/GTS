class Factory extends Building
{
  boolean agvotw = false;
  
  Factory(float x, float y, int z)
  {
    super(x, y, z);
  }

  void display()
  {
    stroke(0);
    beginShape();
    if (demand == 0)
    {
      if (nodenumber < 73)
      { 
        fill(0, 0, 255);
        ellipse(location.x, location.y-50, 15, 15);
      } else if (nodenumber > 72)
      { 
        fill(0, 0, 255);
        ellipse(location.x, location.y+50, 15, 15);
      }
    } else if (demand == 1)
    {
      if (nodenumber < 73)
      { 
        fill(255, 0, 0);
        ellipse(location.x, location.y-50, 15, 15);
      } else if (nodenumber > 72)
      { 
        fill(255, 0, 0);
        ellipse(location.x, location.y+50, 15, 15);
      }
    }
    endShape(CLOSE);
  }
}


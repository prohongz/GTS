class CDC extends Building
{
  CDC(float x, float y, int z)
  {
    super(x, y, z);
  }
  
  void display()
  {
    stroke(0);
    beginShape();
    if (demand == 0)
    {
        fill(0, 0, 255);
        ellipse(location.x+150, location.y-25, 15, 15);
    } else if (demand == 1)
    {
        fill(255, 0, 0);
        ellipse(location.x+150, location.y-25, 15, 15);
    }
    endShape(CLOSE);
  }
}


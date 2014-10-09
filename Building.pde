class Building
{
  PVector location;
  int demand = 0;
  int nodenumber;
  boolean priority = false;

  Building(float x, float y, int number)
  {
    location = new PVector(x, y);
    nodenumber = number;
  }

  //PROBABILITY OF FACTORY TRIGGERING A DEMAND
  void update()
  {
    int r = int(random(0, 10000));
    //print(r, " ");
    if (r == 1)
    {
      demand = 1;
    }
  }
}


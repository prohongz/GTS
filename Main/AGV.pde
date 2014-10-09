class AGV extends Vehicle
{
  //Variables concerning collection and dropping of goods
  boolean cargo = false;
  boolean operation = false;
  ArrayList<PVector> destlist = new ArrayList<PVector>();
  ArrayList<Integer> nodelist = new ArrayList<Integer>();
  int currentnode = 1, target = 1;
  int agvnumber;
  PVector destination = new PVector();

  AGV(float x, float y, int i)
  {
    super(x, y);

    agvnumber = i;
    operation = false;

    destlist.add(new PVector(164, 603));
    nodelist.add(1);
    /*PVector start = new PVector(234, 619);
     destlist.add(start);
     destlist.add(new PVector(209, 619));
     destlist.add(new PVector(201, 669));
     nodelist.add(1);
     nodelist.add(2);
     nodelist.add(3);*/
  }

  //COMMAND FOR CHANGING DESTINATIONS
  void adddestlist(PVector newnodecoord, int newnodenum)
  {
    destlist.add(newnodecoord);
    nodelist.add(newnodenum);
  }

  PVector readdestlist()
  {
    return destlist.get(0);
  }

  void deldestlist()
  {
    currentnode = nodelist.get(0);
    if (destlist.size() > 1)
    {
      destlist.remove(0);
    }
    if (nodelist.size() > 1)
    {
      nodelist.remove(0);
    }
  }
  ///////////////////////////////////

  //COMMAND FOR MODIFYING THE SHAPE OF VEHICLE
  void display()
  {
    //PImage img = loadImage("vehicle.jpg");

    if (cargo == false)
    {
      float theta = velocity.heading2D() + PI/2;
      fill(200);
      stroke(0);
      pushMatrix();
      translate(location.x, location.y);
      rotate(theta);
      beginShape();
      //texture(img);
      vertex(r, -r/2);
      vertex(0, -r*1.5);
      vertex(-r, -r/2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      fill(0);
      textSize(10);
      text(agvnumber, -4, 7);
      popMatrix();
    } else
    {
      float theta = velocity.heading2D() + PI/2;
      fill(0, 255, 0);
      stroke(0);
      pushMatrix();
      translate(location.x, location.y);
      rotate(theta);
      beginShape();
      //texture(img);
      vertex(r, -r/2);
      vertex(0, -r*1.5);
      vertex(-r, -r/2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      fill(0);
      textSize(10);
      text(agvnumber, -4, 7);
      popMatrix();
    }
  }
}


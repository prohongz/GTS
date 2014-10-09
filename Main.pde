PImage bg;

ArrayList<AGV> GF = new ArrayList<AGV>();
ArrayList<Factory> SF = new ArrayList<Factory>();
ArrayList<CDC> CF = new ArrayList<CDC>();

//CHANGE THE NUMBER OF AGV HERE
int AGVNUM = 1;

//MOVEMENT OF VEHICLE TO NODE [ERROR CONTROL]
int error = 1;

//PRIORITY LIST & Destination relevant declaration
ArrayList<Integer> Priority = new ArrayList<Integer>();


//Declaration of Node
Node gps;

//Declaration of inital clock
int speedfactor = 1;

void setup()
{
  size(1300, 700); //DO NOT ADJUST THIS unless absolutely have to
  smooth();
  //frameRate(60);

  bg = loadImage("Map.jpg");

  //ADJUSTMENT FOR NUMBER OF VEHICLE
  for (int i=0; i<AGVNUM; i++)
  {
    GF.add(new AGV(164, 603, i+1));
  }

  //ADJUST NUMBER OF FACTORY HERE
  for (int i=0; i<15; i++)
  {
    SF.add(new Factory(164+(i*54), 74, 58+i));
  }
  for (int i=0; i<15; i++)
  {
    SF.add(new Factory(923-(i*54), 164, 73+i));
  }

  //ADJUST NUMBER OF CDC HERE
  CF.add(new CDC(164, 603, 1));

  //GENERATION OF NODE
  gps = new Node();
  gps.Path();

  //ADJUST NODE XY COORDINATE HERE
  gps.addPoint(164, 603);
  gps.addPoint(119, 603);
  gps.addPoint(119, 649);

  for (int i=0; i<11; i++)
  {
    gps.addPoint(76, 644-(i*50));
  }

  gps.addPoint(80, 102);

  for (int j=0; j<16; j++)
  {
    gps.addPoint(110+(j*54), 99);
  }

  gps.addPoint(965, 100);
  gps.addPoint(965, 138);

  for (int k=0; k<15; k++)
  {

    gps.addPoint(923-(k*54), 139);
  }

  //gps.addPoint(212, 148);

  for (int l=0; l<9; l++)
  {

    gps.addPoint(119, 169+(l*50));
  }

  //FACTORY COORDINATE
  for (int k=0; k<15; k++)
  {
    gps.addPoint(164+(k*54), 54);
  }

  for (int k=0; k<15; k++)
  {
    gps.addPoint(923-(k*54), 184);
  }

  //ADJUST NODE LINKAGE HERE
  for (int i=1; i<57; i++)
  {
    gps.addlink(i, i+1);
  }

  gps.addlink(2, 1);
  gps.addlink(57, 2);

  //FACTORY LINKAGE
  for (int i=0; i<15; i++)
  {
    gps.addlink(58+i, 17+i);
    gps.addlink(17+i, 58+i);
  }

  for (int i=0; i<15; i++)
  {
    gps.addlink(73+i, 34+i);
    gps.addlink(34+i, 73+i);
  } 

  //CHECKING NODE 
  /*
  for (int i=0; i<=gps.nextlink.size ()-1; i++)
   {
   //print(gps.nextlink.size(), "\n");
   for (int j=0; j<=gps.nextlink.get(i).size()-1; j++)
   {
   //print("number of link ", gps.nextlink.get(i).size(), "\n");
   print("current node: ", i+1, "Next node: ", gps.nextlink.get(i).get(j), "\n");
   }
   }*/
}

void draw()
{
  //REMOVE TRAILING EFFECT
  background(bg); 

  //GPS POINT DISPLAY
  gps.display();



  //UPDATE OF FACTORY
  for (Factory w : SF)
  {
    if (w.demand == 0)
    {
      /////print(w.demand, " ");
      w.update();
      w.display();
    } else if (w.demand == 1)
    {
      if (w.priority == false && w.agvotw == false)
      {
        Priority.add(w.nodenumber);
        w.priority = true;
      }
      w.display();
    }
    ///////print(w.nodenumber, " ");
  }


  //UPDATE OF VEHICLE
  for (AGV v : GF)
  {
    //OPERATION COMMAND
    if (v.cargo == false && v.operation == false) //CASE 1 : AGV DOING NOTHING ie park at CDC
    {
      //print(v.agvnumber,"\n");

      if (Priority.size() > 0)
      {
        v.target = Priority.get(0);
        Priority.remove(0);
        if (v.target >57)
        {
          SF.get(v.target - 58).agvotw = true;
        }

        v.operation = true;

        print("target: ", v.target, "\n");
        int simu_node = v.currentnode - 1;
        while ( (simu_node+1) != v.target)
        {
          for (int i=0; i<=gps.nextlink.get (simu_node).size()-1; i++)
          {

            print("current checking node: ", simu_node+1, ". next node is ", gps.nextlink.get(simu_node).get(i), "\n");
            if (gps.nextlink.get(simu_node).get(i) == v.target)
            {
              v.adddestlist(gps.points.get(gps.nextlink.get(simu_node).get(i)-1), gps.nextlink.get(simu_node).get(i));
              print("Node added1: ", simu_node+1, "\n");
              simu_node = v.target -1;
            } 
            if (i==0)
            {
              v.adddestlist(gps.points.get(gps.nextlink.get(simu_node).get(i)-1), gps.nextlink.get(simu_node).get(i));
              print("Node added2: ", simu_node+1, "\n");
              simu_node = gps.nextlink.get(simu_node).get(0)-1;
            }
          }
        }
      }
    }
    if (v.cargo == true && v.operation == true) // CASE 2 : AGV CONVOY TO CDC
    {
      if (v.currentnode == 1) //AGV REACHING CDC DESTINATION
      {
        v.cargo = false;
        v.operation = false;
      }
    }

    if (v.cargo == false && v.operation == true) // CASE 3 : AGV CONVOY TO FACTORY
    {
      //print("hello ", SF.get(v.target - 57).demand, "\n");
      if (v.currentnode == v.target) //AGV REACHING FACTORY DESTINATION
      {
        //print("hello \n");
        SF.get(v.target - 57).demand = 0; // -58 to change to factory number
        SF.get(v.target - 57).agvotw = false;
        v.cargo = true;
        v.target = 1; //change target to CDC

        int simu_node = v.currentnode - 1;
        while ( (simu_node+1) != v.target)
        {
          for (int i=0; i<=gps.nextlink.get (simu_node).size()-1; i++)
          {

            print("current checking node: ", simu_node+1, ". next node is ", gps.nextlink.get(simu_node).get(i), "\n");
            if (gps.nextlink.get(simu_node).get(i) == v.target)
            {
              v.adddestlist(gps.points.get(gps.nextlink.get(simu_node).get(i)-1), gps.nextlink.get(simu_node).get(i));
              print("Node added1: ", simu_node+1, "\n");
              simu_node = v.target -1;
            } 
            if (i==0)
            {
              v.adddestlist(gps.points.get(gps.nextlink.get(simu_node).get(i)-1), gps.nextlink.get(simu_node).get(i));
              print("Node added2: ", simu_node+1, "\n");
              simu_node = gps.nextlink.get(simu_node).get(0)-1;
            }
          }
        }
      }
    }

    print("my currentnode: ", v.currentnode, "my target is: ", v.target, "my operation", v.operation, "my cargo", v.cargo, "\n");



    //UPDATE DESTINATION
    if (abs(v.location.y - (v.readdestlist().y)) > error)
    {
      if (abs(v.location.x - (v.readdestlist().x)) > error)
      {
        v.destination = v.readdestlist();
      }
    } else if (abs(v.location.x - (v.readdestlist().x)) > error)
    {
      if (abs(v.location.y - (v.readdestlist().y)) > error)
      {
        v.destination = v.readdestlist();
      }
    } else
    {
      if (v.destlist.size() > 0)
      {
        v.deldestlist();
        v.destination = v.readdestlist();
      }
    }
    //print("my nextnode: ", v.nodelist.get(0), v.destination, "\n");


    //MOVE OPERATION
    v.arrive(v.destination);

    //FOR DISPLAY
    v.update();
    v.display();
  }



  /*
  for (CDC u : CF)
   {
   if (u.demand == false)
   {
   /////print(u.demand, " ");
   u.display();
   } else if (u.demand == true)
   {
   u.display();
   }
   ///////print(u.nodenumber, " ");
   }
   */


  int m=((millis()/1000)-0)*speedfactor, h=0, d=0;
  if (m>59)
  {
    h=m/60;
    m=m%60;
    if (h>23)
    {
      d=h/24;
      h=h%24;
    }
  }
  beginShape();
  fill(0);
  textSize(20);
  textAlign(RIGHT);
  text(d, 1080, 75);
  textAlign(LEFT);
  text("d", 1140, 75);
  text(h, 1160, 75);
  text("h", 1190, 75);
  text(m, 1210, 75);
  text("m", 1240, 75);
  endShape();
}


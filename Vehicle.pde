class Vehicle
{
  //Variables concerning physicals of the vehicles
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;


  Vehicle(float x, float y)
  {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r=6.0;
    maxspeed = 2.0;
    maxforce = 0.25;
  }

  //"No brain driving at maxspeed" CASE 1
  void seek(PVector target) 
  {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    acceleration.add(steer);
  }

  // Smart driving CASE 2
  void arrive(PVector target) 
  {
    PVector desired = PVector.sub(target, location);

    float d = desired.mag();
    desired.normalize();

    if (d<50)      //Change to adjust deacceleration distance
    {
      float m = map(d, 0, 25, 0, maxspeed);
      desired.mult(m);
    } else
    {
      desired.mult(maxspeed);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    acceleration.add(steer);
  }

  //COMMAND FOR UPDATING VEHICLE PHYSICS
  void update()
  {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  ////////////////////////////////////
}


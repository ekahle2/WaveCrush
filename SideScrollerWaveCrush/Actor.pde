
class Actor
{

  float posX,posY,velX,velY;
  float accX,accY;
  int actorW,actorH;
  

  
  PVector target,renTarget;
  float moveSpeed;
  
  float time, duration;
  PVector beginningVec, changeVec;
  
  boolean ai;
  boolean hasCollided;

  color statusCol;
  
  //collision animation particle system
  ParticleSystem ps;
  
  int colisionAnimationTimeLimit;
  int colisionTimer;
  
  Actor()
  {
    actorW = actorH = 50;
    
    posX = width/2;
    posY = height/2;
    velX = velY = 0;
    

    duration = 50;
    ai = false;
    hasCollided = false;
    
    target = new PVector(posX,posY);
    renTarget = new PVector(posX,posY);
    beginningVec= new PVector(posX,posY);
    changeVec= new PVector();
    
    statusCol = color(255,255,255);
    colisionAnimationTimeLimit = 50;
    colisionTimer = 0;
    ps = new ParticleSystem(new PVector(width/2,height/2));
    
    moveSpeed = 3;
  }
  
  Actor(float _x, float _y, int _duration, boolean _ai)
  {
    actorW = actorH = 50;
    
    posX = _x;
    posY = _y;
    velX = velY = 0;
    

    duration = _duration;
    ai = _ai;
    
    target = new PVector(posX,posY);
    renTarget = new PVector(posX,posY);
    beginningVec= new PVector(posX,posY);
    changeVec= new PVector();
    
    colisionAnimationTimeLimit = 30;
    colisionTimer = 0;
    ps = new ParticleSystem(new PVector(width/2,height/2));
    
    moveSpeed = 3;
    
  }  
  
  public PVector getCenter()
  {
    return new PVector( posX+ (actorW/2), posY+ (actorH/2) );      
  }
  
  public PVector getSize()
  {
    return new PVector( actorW, actorH );      
  } 
 
  public float getRadius()
  {
    return (actorW >= actorH ? actorW:actorH);      
  }    
  
  public PVector getPosition()
  {
    return new PVector( posX, posY );      
  }

  public PVector getAcceleration()
  {
    return new PVector( accX, accY ); 
  }

  public void updatePosition(float _x, float _y)
  {
    posX = _x ;
    posY = _y ;
  }

  public void addToPosition(float _x, float _y)
  {
    float newPosX = posX+_x;
    float newPosY = posY+_y;
    
    if(newPosX >= getRadius()-actorW && newPosX <= width- getRadius())
    {
      posX = newPosX;
    }
    
    if(newPosY >= 0 && newPosY <= height- actorH )
    {
      posY = newPosY;
    }    
    
    
    
    
  }
  
  public void moveLeft()
  {
    float newPosX = posX -this.moveSpeed;
    if(newPosX >= getRadius()-actorW )
    {
      posX = newPosX;
    }
  }
  
  public void moveRight()
  {
    float newPosX = posX +this.moveSpeed;
    if( newPosX <= width- getRadius() )
    {
      posX = newPosX;
    }
  }  
  
  public void moveUp()
  {
    float newPosY = posY-this.moveSpeed;
    if(newPosY >= 0 )
    {
      posY = newPosY;
    }
  }    
  
  public void moveDown()
  {
    float newPosY = posY+this.moveSpeed;
    if( newPosY <= height- actorH )
    {
      posY = newPosY;
    }
  }  
  
  

  public void updateTarget( PVector _target)
  {
    target = _target;   
    target.x-=getCenter().x;
    target.y-=getCenter().y;
    
    time = 0;
    beginningVec.set( getPosition() );
    changeVec.set(_target);
    
    renTarget.set(_target.x+posX+ (actorW/2), _target.y+posY+ (actorH/2),0);
    
  }

  public void updateAcceleration(PVector _accVec)
  {
    

    
    
    
    
  }

//  private void updatePosition()
//  {
//   
//    
//    posX = Expo.easeInOut(time, beginningVec.x, changeVec.x, duration );
//    posY = Expo.easeInOut(time, beginningVec.y, changeVec.y, duration );
//    
//    //posX = Elastic.easeInOut(time, beginningVec.x, changeVec.x, duration );
//    //posY = Elastic.easeInOut(time, beginningVec.y, changeVec.y, duration );
//    
//    ellipse(renTarget.x ,renTarget.y ,10,10);
//    ellipse(posX,posY,10,10);
//    
//    //line(posX, posY, target.x,target.y);
//    
//    if(ai && (time>duration) )
//    {
//      float seedY = random(10,height-10);
//      updatePosition(width, seedY);
//      updateTarget(new PVector( -this.actorW ,seedY+(getSize().y/2)));
//    }
//  }  
  
  void draw()
  {
    //updatePosition();
    
    //fill(255);
    //rect(posX,posY,actorW,actorH);
    
    time++;
  }
  
  boolean collisionCheck(float _x, float _y, float _radius)
  {
    PVector center = getCenter();
    
    if( inCircle( center.x , center.y , (actorW >= actorH ? actorW:actorH)     ,_x,_y  ) )
    {
      return true;
    }
    
    return false;
  
  }
  
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,random(-.05,.05));
    velocity = new PVector(random(-1,1),random(-1,1));
    location = l.get();
    lifespan = 50.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255,lifespan);
    fill(255,lifespan);
    ellipse(location.x,location.y,8,8);
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove(); 
      }
    }
  }
}
  

}



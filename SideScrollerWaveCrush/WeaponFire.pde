

class WeaponFire
{

  float posX,posY;
  int actorW,actorH;
  
  PVector target,renTarget;
  PVector beginningVec, changeVec;
  boolean hasCollided;
  
  float time, duration;//duration for movement
  
  int damage;
  int lifeSpan;//how long will this object live
  int lifeStart;
  
  int colisionAnimationTimeLimit;
  int colisionTimer;
  
  float a;
  
  WeaponFire(float _x, float _y)
  {
    actorW = actorH = 50;
    
    posX = _x;
    posY = _y;
    
    

    duration = 100;

    
    target = new PVector(posX,posY);
    renTarget = new PVector(posX,posY);
    beginningVec= new PVector(posX,posY);
    changeVec= new PVector();
    
    damage = 1;
    lifeSpan = 300;
    lifeStart = millis();
    
    colisionAnimationTimeLimit =30;
    colisionTimer = 0;
  } 
  
  WeaponFire(float _x, float _y, PVector _target, int _damage)
  {
    actorW = actorH = 50;
    
    posX = _x;
    posY = _y - (actorH/2);
    
    

    duration = 50;

    
    target = _target;
    renTarget = _target;
    beginningVec= new PVector(posX,posY);
    changeVec= new PVector();
    
    damage = 1;
    lifeSpan = 1000;
    lifeStart = millis();
    
    updateTarget(_target);
    
    damage = _damage;
    
    colisionAnimationTimeLimit = 30;
    colisionTimer = 0;
    a = atan2(target.y -posY , target.x - posX);
    println(radians(a));
  } 

  WeaponFire(float _x, float _y, PVector _target, int _damage,int _angle)
  {
    actorW = actorH = 50;
    
    posX = _x;
    posY = _y - (actorH/2);
    
    

    duration = 50;

    
    target = _target;
    renTarget = _target;
    beginningVec= new PVector(posX,posY);
    changeVec= new PVector();
    
    damage = 1;
    lifeSpan = 1000;
    lifeStart = millis();
    
    updateTarget(_target);
    
    damage = _damage;
    
    colisionAnimationTimeLimit = 30;
    colisionTimer = 0;
    a = radians(_angle);
    println(radians(a));
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
  
  boolean collisionCheck(float _x, float _y, float _radius)
  {
    PVector center = getCenter();
    
    if( inCircle( center.x , center.y , (actorW >= actorH ? actorW:actorH)     ,_x,_y  ) )
    {
      return true;
    }
    
    return false;
  
  }
  
  boolean isAlive()
  {
    if(millis() - lifeStart > lifeSpan)return false;
    
    return true;
    
  }
  
  
  private void updatePosition()
  {
   
    
    posX = Linear.easeInOut(time, beginningVec.x, changeVec.x, duration );
    posY = Linear.easeInOut(time, beginningVec.y, changeVec.y, duration );
    
    //posX = Expo.easeInOut(time, beginningVec.x, changeVec.x, duration );
    //posY = Expo.easeInOut(time, beginningVec.y, changeVec.y, duration );
    
    //posX = Elastic.easeInOut(time, beginningVec.x, changeVec.x, duration );
    //posY = Elastic.easeInOut(time, beginningVec.y, changeVec.y, duration );
  
  }

  //action to be preformed when weaponFire collides with actors
  void doCollion()
  {
    //push event at this position to sprite effect manager list
    //play sound
    
    
  }  
  
  void draw()
  {
    PVector prevPos = getCenter();
    updatePosition();
    
    fill(255);
    //rect(posX,posY,actorW,actorH);
    
//    pushStyle();
//    noFill();
//    strokeWeight(5);
//    stroke(230,10,70,100);
//    float c1 = actorW*(sin(time*.1));
//    ellipse(posX,posY,c1,c1);
//    stroke(250,110,30,100);
//    c1 = actorW*cos(time*.1+7);
//    ellipse(posX,posY,c1,c1);
//    popStyle();

    pushStyle();
    
    stroke(230,10,70,100);
    strokeWeight(10);
    //todo: rotate weapon fire based on angle
    pushMatrix();
      //translate(posX,posY);
      translate(posX-5 , posY-5 );
      
      //float a = atan2( posX - prevPos.x, posY - prevPos.y);
      
      rotate(a);
      //rect(0,0,100,100);
      //line(posX,posY,posX+50,posY);
      line(0,0,10,0);
      
      //translate(0,0);
    popMatrix();
    
    popStyle();
    
    
    //println(posX+ " " + posY);
    time++;
  }
    
  
}

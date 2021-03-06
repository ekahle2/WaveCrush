
class Player extends Actor
{

  PImage playerImg = loadImage("Player.png");
  
  Player()
  {
  
    super();
    duration = 25;
    actorW = playerImg.width;
    actorH = playerImg.height;
    weaponFireRate = 25;
    //colisionAnimationTimeLimit = 1000;
    actorHealth  = 10;
    actorCurrentHealth = actorHealth;
  }

  Player(float _x, float _y, int _duration, boolean _ai)
  {
    super(_x, _y, _duration, _ai, 25,10);

  }

  private void updatePosition()
  {
    
    super.updatePosition();
    if(hasCollided && (colisionTimer > colisionAnimationTimeLimit) )
    {
      resetCollision();
    }
   
    if(time<duration){
      posX = Linear.easeIn(time, beginningVec.x, changeVec.x, duration );
      posY = Linear.easeIn(time, beginningVec.y, changeVec.y, duration );
      //println( time + " " + duration);
      ellipse(renTarget.x ,renTarget.y ,10,10);
      ellipse(posX,posY,10,10);
    }
    
    if(ai && (time>duration) )
    {
      float seedY = random(10,height-10);
      updatePosition(width, seedY);
      updateTarget(new PVector( -this.actorW ,seedY+(getSize().y/2)));
    }
  }
  
  void draw()
  {
    updatePosition();
    super.draw();
    //image(playerImg, getCenter().x - (playerImg.width/2),getCenter().y - (playerImg.height/2));
    
//    pushStyle();
//    fill(200,100);
//    ellipse(posX,posY,50,50);
//    popStyle();
    if(true)image(playerImg, int(posX - (playerImg.width/2) ), int(posY- (playerImg.height/2) ) );

  }


  boolean addWeponFire()
  {
    if(!super.addWeponFire())return false;
    
    int fireLength = width;
    PVector pos = getCenter();
    
    int angle = 0;
    int endPointX = int(pos.x + (fireLength )*cos(radians(angle)));
    int endPointY = int(pos.y + (fireLength )*sin(radians(angle)));
    wfm.addWeponFire(new WeaponFire( pos.x + (actorW/2) + 10, pos.y + (actorH/2), new PVector(endPointX, endPointY ), 10,angle  ) );
    
    //TODO: determin fire angle
    angle = -30;
    endPointX = int(pos.x + (fireLength )*cos(radians(angle)));
    endPointY = int(pos.y + (fireLength )*sin(radians(angle)));
    wfm.addWeponFire(new WeaponFire( pos.x + (actorW/2) + 10, pos.y + (actorH/2), new PVector(endPointX, endPointY  ), 10 ,angle ) );
    
    angle = 30;
    endPointX = int(pos.x + (fireLength )*cos(radians(angle)));
    endPointY = int(pos.y + (fireLength )*sin(radians(angle)));
    wfm.addWeponFire(new WeaponFire( pos.x + (actorW/2) + 10, pos.y + (actorH/2), new PVector(endPointX, endPointY  ), 10 ,angle ) );    
    return true;
  }


}

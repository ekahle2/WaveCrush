
class Player extends Actor
{

  PImage playerImg = loadImage("Player.png");
  
  Player()
  {
  
    super();
    duration = 25;
    actorW = playerImg.width;
    actorH = playerImg.height;
    
  }

  Player(float _x, float _y, int _duration, boolean _ai)
  {
    super(_x, _y, _duration, _ai);
  }

  private void updatePosition()
  {
   
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
    image(playerImg, getCenter().x - (playerImg.width/2),getCenter().y - (playerImg.height/2));
    

  }


  void addWeponFire()
  {
    PVector pos = getCenter();
    wfm.addWeponFire(new WeaponFire( pos.x, pos.y, new PVector(width, pos.y)  ) );
  }

}

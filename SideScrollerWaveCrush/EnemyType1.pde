
class EnemyType1 extends Actor
{

  PImage EnemyType1Img = loadImage("EnemyType1.png");
  
  EnemyType1()
  {
  
    super();
    duration = 25;
    actorW = EnemyType1Img.width;
    actorH = EnemyType1Img.height;
    
  }

  EnemyType1(float _x, float _y, int _duration, boolean _ai)
  {
    super(_x, _y, _duration, _ai);
  }

  private void updatePosition()
  {
   
    if(hasCollided && (colisionTimer < colisionAnimationTimeLimit) )
    {
      pushStyle();
      ps.addParticle();
      ps.run();
      popStyle();
      colisionTimer++;
      return;
    }
    if(hasCollided && (colisionTimer > colisionAnimationTimeLimit) )
    {
      
    
      resetEnemy();
    }
    
    if(!hasCollided || (time<duration)){
      posX = Expo.easeInOut(time, beginningVec.x, changeVec.x, duration );
      posY = Expo.easeInOut(time, beginningVec.y, changeVec.y, duration );
      //println( time + " " + duration);
      
      //ellipse(renTarget.x ,renTarget.y ,10,10);
      //ellipse(posX,posY,10,10);
      
    }
    
    if(ai && (time>duration) )
    {
//      float seedY = random(10,height-10);
//      updatePosition(width, seedY);
//      updateTarget(new PVector( -this.actorW ,seedY+(getSize().y/2)));
//      hasCollided = false;
//      statusCol = color(255,255,255);
//      colisionTimer = 0;
      resetEnemy();
    }
    
    PVector cen = this.getCenter();
    PVector lookup = new PVector();
    for(int i = (int)(cen.x- (actorW/2) ) ; i <= (int)(cen.x + (actorW/2) ) ; i++)
    {
      if(hasCollided)break;
      for(int j = (int)(cen.y- (actorH/2) ) ; j <= (int)(cen.y + (actorH/2) ) ; j++)
      {
        if(hasCollided)break;
        lookup.set(j,i,0);
        if( wfm.wfCollision( lookup ) > 0 )
        {
          hasCollided = true;
          
          println(true);
          statusCol = color(255,0,0);
          ps.origin = new PVector(i,j);
        }
      }
      
    }
    
    if(hasCollided)
    {
      colisionTimer++;
    }
    
    
//    if( wfm.wfCollision( this.getCenter() ) > 0 )
//    {
//      hasCollided = true;
//      println(true);
//    }
    
  }
  
  void resetEnemy()
  {
      float seedY = random(10,height-10);
      updatePosition(width, seedY);
      updateTarget(new PVector( -this.actorW ,seedY+(getSize().y/2)));
      hasCollided = false;
      statusCol = color(255,255,255);
      colisionTimer = 0;
      ps.particles.clear();
  }
  
  void draw()
  {
    updatePosition();
    super.draw();
    //image(playerImg, getCenter().x - (playerImg.width/2),getCenter().y - (playerImg.height/2));
    pushStyle();
    //fill(statusCol);
    //if(!hasCollided)rect(posX,posY,actorW,actorH);
    if(!hasCollided)image(EnemyType1Img, int(posX + (actorW/2)), int(posY + (actorH/2)) );
    
    popStyle();

  }

}

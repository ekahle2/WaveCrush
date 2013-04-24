
class EnemyType1 extends Actor
{

  PImage EnemyType1Img = loadImage("EnemyType1.png");
  
  EnemyType1()
  {
  
    super();
    duration = 25;
    actorW = EnemyType1Img.width;
    actorH = EnemyType1Img.height;
    weaponFireRate = 50;
    
  }

  EnemyType1(float _x, float _y, int _duration, boolean _ai)
  {
    super(_x, _y, _duration, _ai, 50 );
    
  }

  private void updatePosition()
  {
   
    super.updatePosition();
    
//    if(hasCollided && (colisionTimer < colisionAnimationTimeLimit) )
//    {
//      pushStyle();
//      ps.addParticle();
//      ps.run();
//      popStyle();
//      colisionTimer++;
//      return;
//    }
    if(hasCollided && (colisionTimer > colisionAnimationTimeLimit) )
    {
      
    
      resetEnemy();
    }
    
    if(!hasCollided || (time<duration)){
      posX = Expo.easeInOut(time, beginningVec.x, changeVec.x, duration );
      posY = Expo.easeInOut(time, beginningVec.y, changeVec.y, duration );
    }
    
    if(ai && (time>duration) )
    {
      resetEnemy();
    }
    
//    PVector cen = this.getCenter();
//    PVector lookup = new PVector();
//    for(int i = (int)(cen.x- (actorW/2) ) ; i <= (int)(cen.x + (actorW/2) ) ; i++)
//    {
//      if(hasCollided)break;
//      for(int j = (int)(cen.y- (actorH/2) ) ; j <= (int)(cen.y + (actorH/2) ) ; j++)
//      {
//        if(hasCollided)break;
//        lookup.set(j,i,0);
//        if( wfm.wfCollision( lookup ) > 0 )
//        {
//          hasCollided = true;
//          
//          statusCol = color(255,0,0);
//          ps.origin = new PVector(i,j);
//        }
//      }
//      
//    }
    
//    if(hasCollided)
//    {
//      colisionTimer++;
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
    pushStyle();
    
//    pushStyle();
//    fill(200,100);
//    ellipse(posX,posY,50,50);
//    popStyle();
    if(!hasCollided)image(EnemyType1Img, int(posX - (EnemyType1Img.width/2) ), int(posY- (EnemyType1Img.height/2) ) );
    
    popStyle();

  }
  
  boolean addWeponFire()
  {
    if(!super.addWeponFire())return false;
    
    PVector pos = getCenter();
    wfm.addWeponFire(new WeaponFire( pos.x + (actorW/2), pos.y + (actorH/2), new PVector(width, pos.y + (actorH/2))  ) );
    
    return true;
  }
  


}

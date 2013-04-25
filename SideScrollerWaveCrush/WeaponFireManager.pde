/**

this class will be the manager for the 'projectiles' in the game

*/

class WeaponFireManager
{

  ArrayList weaponFireCollection;
  int[] collisionMap = new int[width*height];
  
  WeaponFireManager()
  {
    weaponFireCollection = new ArrayList();
    Arrays.fill(collisionMap, 0);
  }
  
  void addWeponFire(  WeaponFire _wp  )
  {
    weaponFireCollection.add(_wp);
  }
  
  void draw()
  {
  
    Arrays.fill(collisionMap, 0);
    if(weaponFireCollection.size() <=0)return;
    
    for(int i = 0 ; i < weaponFireCollection.size() ; i++)
    {
    
      WeaponFire wp = (WeaponFire)weaponFireCollection.get(i);
      wp.draw();
      
      //collisionMap[ int( width * 10 + 10) ] = 255;
      

      
      //deprecated at this point
      //really good idea for efficant collision lookup
      //bad use case
      for(int j = (int)wp.posX; j <= (int)(wp.posX+wp.actorW) ;  j++)
      {
        if(j > width)continue;
        int index = int( height * wp.posY + j);
        if( !(index > collisionMap.length-1 || index < 0 ))
        {
          collisionMap[ index ] = wp.damage;
        }
      }

      
      
      if( !wp.isAlive())
      {
        weaponFireCollection.remove(i);
        continue;
      }
      //the 'new' collision logic, may have issues at larger N
      for(int j = 0 ; j < aList.size() ; j++)
      {
          EnemyType1 ai = (EnemyType1)aList.get(j);
          if(ai.collisionCheck(wp.posX, wp.posY , ai.getRadius() ) )
          {
            wp.doCollion();
            weaponFireCollection.remove(i);
            if( !ai.takeDamage( wp.damage ) )ai.doCollision();
            
            break;
          }
          
      }
      
    
    }
    
  }
  

  //deprecated at this point
  //really good idea for efficant collision lookup
  //bad use case
  int wfCollision(PVector _pos)
  {
     
    int index = int( height * _pos.x + _pos.y);
    if(index > collisionMap.length-1 || index < 0)return 0;
    
    try{
      return collisionMap[ index ];
    }catch(ArrayIndexOutOfBoundsException e)
    {
      println("bad index: " + index);
    }
    return 0;
  }
  
}

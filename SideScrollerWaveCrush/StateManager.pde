
//state machine

class StateManager
{

  Status state;
  
  
  StateManager()
  {
    state = Status.MENU;
  }
  
  void go()
  {

    switch(state)
    {
    
      case STARTING:
      
      break;//end starting

      case MENU:
        stateManagerEventHandler();
        

        mainMenu.draw();
        
      
      break;//end menu
      
      case DEMO:
      
      break;//end demo
      
      case PLAY:

        stateManagerEventHandler();
        
        //draw background
        BM.draw();
  
        //player movment
        doPlayerMovement();
  
        //draw player
        a.draw();
      
        //enemy render and update
        for(int i = 0 ; i < aList.size() -1 ; i++)
        {
          EnemyType1 ai = (EnemyType1)aList.get(i);
          ai.draw();
          
          PVector pos = ai.getCenter();
          //ellipse(pos.x, pos.y , ai.getRadius(), ai.getRadius());
          if( !ai.hasCollided && a.collisionCheck(pos.x, pos.y , ai.getRadius() ) )
          {
            collisionCount++;
            //trigger player colision 
            a.doCollision();
            
            //a.hasCollided = true;
            //a.ps.origin = a.getCenter();
            
            ai.hasCollided = true;
            ai.ps.origin = new PVector(pos.x, pos.y);
          }
        }
      
        wfm.draw();
        textFont(debugFont);
        text(collisionCount, 50,50);
        text(frameRate, 50,75);
        text(timer, 50,100);
        text(""+a.hasCollided, 50,125);
        
        timer++;//global timer
        
        
        //debug to see colision events 
        //tempI.pixels = wfm.collisionMap;
        //tempI.updatePixels();
        //image(tempI,0,0);

      
      
      break;//end play
      
      case PAUSE:
      
      break;//end pause
      
      case END:
      
        exit();
      
      break;//end END
      
      case CREDITS:
      
      break;//end credits
      
      
    
    }//end state case
    
    
  
  }//end go
  
  //wrapper for player movment
  void doPlayerMovement()
  {
      //println(dPadMovement[0] + " " + dPadMovement[1] + " " + dPadMovement[2] + " " + dPadMovement[3] + " " + dPadMovement[4]);
      if (dPadMovement[0]) {
          a.moveLeft();
      }
      
      if (dPadMovement[1]) {
          a.moveRight();
      } 
     
      if (dPadMovement[2]) {
          a.moveUp();
      } 
    
      if (dPadMovement[3]) {
          a.moveDown();
      } 
 
      if (dPadMovement[4]) {
          a.addWeponFire();
      }
      
  }
  
  //leave direct settor for now, I think proper way would be accessor methods for each state
  void setState( Status s)
  {
  
    state = s;
  }
  
  void stateManagerEventHandler()
  {
        if(keyPressed && key =='p') state = Status.PLAY;
        if(keyPressed && key =='m') state = Status.MENU;
  }
  
  void togglePauseMenu()
  {
    
    if(state == Status.PLAY){
      println(state);
      state = Status.MENU;
    }else{
      state = Status.PLAY;
    }
    
  }



}//end stateManager

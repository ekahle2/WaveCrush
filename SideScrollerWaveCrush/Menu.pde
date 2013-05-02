class Menu
{
  PFont menuFont;
  int selectedIndex;
  PVector[] menuPos;
  
  Menu()
  {
  
    menuFont = createFont("Arial", 40);
    selectedIndex = 0;
    menuPos = new PVector[3];
    
    menuPos[0] = new PVector( width/2,(height/2) - 100  );
    menuPos[1] = new PVector( width/2,(height/2) - 0    );
    menuPos[2] = new PVector( width/2,(height/2) + 100  );
    
  }
  
  void draw()
  {
  
        BM.draw();
        ellipse(mouseX,mouseY,10,10);
        
        
        pushStyle();
        textFont(menuFont,40);
        textAlign(CENTER);
        text("Play", menuPos[0].x,  menuPos[0].y     );
        text("Options", menuPos[1].x,  menuPos[1].y  );
        text("Quit", menuPos[2].x,  menuPos[2].y     );
        popStyle();
        
        pushStyle();
        textAlign(CENTER);
        textFont(menuFont,40 + sin(millis()*.005)*6  );
        text(">", menuPos[selectedIndex].x - 100,  menuPos[selectedIndex].y);
        popStyle();
  }
  
  public void nextSelection()
  {
    selectedIndex++;
    if(selectedIndex>=menuPos.length)selectedIndex=0;
  }
  
  public void previousSelection()
  {
    selectedIndex--;
    if(selectedIndex<0)  selectedIndex=menuPos.length-1;
  }
  
  public void makeSelection()
  {
  
    switch(selectedIndex){
    
      case 0:
        stateManager.state = Status.PLAY;
        break;
      case 1:
        //stateManager.state = Status.MENU;
        println("TODO: create options state");
        break;  
      case 2:
        stateManager.state = Status.END;
        break;  
    }
    
  }
  


}

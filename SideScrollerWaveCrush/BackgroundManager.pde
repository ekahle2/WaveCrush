

class BackgroundManager
{

  PGraphics L1buffer;
  PImage L1Image;
  float L1Offset;
  float L1OffsetA,L1OffsetB;
  
  BackgroundManager()
  {
    L1Offset = 0;
    L1OffsetA = 0;
    L1OffsetB = 0;
    initL1Background();
  }
  
  
  void draw()
  {
  
    doL1Background();
  }
  
  void initL1Background()
  {
    L1buffer = createGraphics(width*1, height, OPENGL);
    L1buffer.beginDraw();
    L1buffer.background(0);
    L1buffer.stroke(255);
    
    L1OffsetA = 0;
    L1OffsetB = L1buffer.width;
    for(int i = 0 ; i < 10000 ; i++)
    {
      
      L1buffer.point(random(width*3), random(height) );
    }

    L1buffer.endDraw();
    L1Image = L1buffer.get(int(0+L1Offset), 0, int(width+L1Offset), int(L1buffer.height));
    image(L1buffer,L1OffsetA,0);
  }
  
  void doL1Background()
  {
    
    updateL1Background();
    image(L1buffer,L1OffsetA,0);
    image(L1buffer,L1OffsetB,0);
   
  }
  
  void doStaticBackground()
  {
    image(L1buffer,0,0);
  }
  
  void updateL1Background()
  {
    if(stateManager.state == Status.PLAY){
      L1OffsetA-=.5;
      L1OffsetB-=.5;
    }
    
    if(L1OffsetA < -L1buffer.width) L1OffsetA = width;   
    if(L1OffsetB < -L1buffer.width) L1OffsetB = width;

  }
}

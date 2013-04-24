//test
import processing.opengl.*;
import penner.easing.*;

import java.util.*;


import java.util.Iterator;

Player a;
long timer = 0;

ArrayList aList = new ArrayList();
int collisionCount = 0;

WeaponFireManager wfm;

PImage tempI;

BackgroundManager BM;

float moveSpeed = 3;
boolean[] dPadMovement = new boolean[4];
//0 - LEFT
//1 - RIGHT
//2 - UP
//3 - DOWN

StateManager stateManager;


void setup()
{

  size(500,500, OPENGL);
  frameRate(60);
  BM = new BackgroundManager();

  wfm = new WeaponFireManager();

  a = new Player();


  for(int i = 0 ; i < 15 ; i++)
  {
    float seedY = random(10,height-10);
    
    EnemyType1 ai = new EnemyType1(width, seedY, (int)random(500,700), true);
    ai.updateTarget(new PVector( -ai.actorW  ,seedY+(ai.getSize().y/2)));
    
    
    aList.add(ai);
  }
  
  tempI = new PImage(width,height,ALPHA );

  Arrays.fill(dPadMovement, false);

  
  stateManager = new StateManager();


}


void draw()
{
  smooth();
  
  stateManager.go();
  
  BM.draw();
  
  
  
  if(mousePressed){
    PVector pos = a.getCenter();
    wfm.addWeponFire(new WeaponFire( pos.x, pos.y, new PVector(width, pos.y)  ) );
  }
  
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
  
  a.draw();
  
  for(int i = 0 ; i < aList.size() -1 ; i++)
  {
    Actor ai = (Actor)aList.get(i);
    ai.draw();
    
    PVector pos = ai.getCenter();
    //ellipse(pos.x, pos.y , ai.getRadius(), ai.getRadius());
    if( !ai.hasCollided && a.collisionCheck(pos.x, pos.y , ai.getRadius() ) )
    {
      collisionCount++;
      ai.hasCollided = true;
      ai.ps.origin = new PVector(pos.x, pos.y);
    }
  }
  
  wfm.draw();
  
  text(collisionCount, 50,50);
  text(frameRate, 50,75);
  text(timer, 50,100);
  timer++;//global timer
  
  
  //debug to see colision events 
  //tempI.pixels = wfm.collisionMap;
  //tempI.updatePixels();
  //image(tempI,0,0);
  

}

void keyPressed() 
{

    if (keyCode == LEFT) {
      dPadMovement[0] = true;
    }
    if (keyCode == RIGHT) {
      dPadMovement[1] = true;
    }
    if (keyCode == UP) {
      dPadMovement[2] = true;
    }
    if (keyCode == DOWN) {
      dPadMovement[3] = true;
    }    
    
  
  //trigger player weapon on spacebar  
  if(key== ' ')
  {
    PVector pos = a.getCenter();
    wfm.addWeponFire(new WeaponFire( pos.x, pos.y, new PVector(width, pos.y)  ) );

  }

}

void keyReleased()
{
    if (keyCode == LEFT) {
      dPadMovement[0] = false;
    }
    if (keyCode == RIGHT) {
      dPadMovement[1] = false;
    }
    if (keyCode == UP) {
      dPadMovement[2] = false;
    }
    if (keyCode == DOWN) {
      dPadMovement[3] = false;
    }    

}

//void mousePressed()
//{
//  PVector pos = a.getCenter();
//  wfm.addWeponFire(new WeaponFire( pos.x, pos.y, new PVector(width, pos.y)  ) );
//}

boolean inCircle(float _center_x, float _center_y, float _radius, float _x, float _y)
{

  float square_dist = pow( (_center_x - _x) , 2) + pow( (_center_y - _y) , 2);
  
  return  square_dist < pow(_radius,2) ;

}



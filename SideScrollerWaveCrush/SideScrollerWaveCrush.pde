
/*
  Import liberarys
*/

import processing.opengl.*;
import penner.easing.*;
import java.util.*;
import java.util.Iterator;

/*
  Init global varables
*/

Player a;                            //player object 
long timer = 0;                      //global timer

ArrayList aList = new ArrayList();   //enemy actor list
int collisionCount = 0;              //player collision count, used as debugging health meter

WeaponFireManager wfm;               //weapon fire manager, used to manage weapon sprites

PImage tempI;                        //image used to debug weapon collision map                          

BackgroundManager BM;                //manager to handel background rendering
               
boolean[] dPadMovement = new boolean[5];  //collection to manager simultanious keyboard events
//0 - LEFT
//1 - RIGHT
//2 - UP
//3 - DOWN
//4 - FIRE

StateManager stateManager;          //state manager object

/*
  global setup method
*/

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

/*
  Main draw loop
*/

void draw()
{
  smooth();
  
  stateManager.go();
  
}

/*
  Key Pressed Event Handeler
*/

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
      dPadMovement[4] = true;
  
  
    }

}

/*
  Key Released Event Handler
*/

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
    if (key== ' ') {
      dPadMovement[4] = false;
    }       

}

//void mousePressed()
//{

//}

/*
  Utility method to detect a point within a circle
*/
boolean inCircle(float _center_x, float _center_y, float _radius, float _x, float _y)
{

  float square_dist = pow( (_center_x - _x) , 2) + pow( (_center_y - _y) , 2);
  
  return  square_dist < pow(_radius,2) ;

}



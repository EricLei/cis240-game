/**
 * mc.c
 * CIS240 Fall 2016
 */

#include "lc4libc.h"

/************************************************
 *  DATA STRUCTURES FOR GAME STATE
 ***********************************************/

/** Width and height of lc4 */
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 124

/** Number of cities and launchers in the game */
#define NUM_CITIES 2

/** Number of targets incoming can target (cities + 1 launcher) */
#define NUM_TARGETS NUM_CITIES+1 

/** Number of maximum outgoing and incoming allowed on the screen */
#define MAX_OUTGOING 1
#define MAX_INCOMING 3

/** Number of missiles allowed per round*/
#define MISSILES_PER_ROUND 8

/** The y position of where the cities and launcher are located */
#define GROUND_LEVEL 116

/** The x positions of where the cities and launcher are located */
#define LEFT_CITY_XPOS	20
#define RIGHT_CITY_XPOS 100
#define MISSILE_COMMAND_XPOS 60

/** The squared distance where missiles will contact
 * if it is in the radius */
#define CONTACT_RADIUS 250

/** Delay between GETC_TIMER - default at 10ms */
#define GETC_TIMER_DELAY 5

/** 2D array presenting the cursor */
lc4uint cursorImage[] = {
  0x00,
  0x00,
  0x18,
  0x3C,
  0x3C,
  0x18,
  0x00,
  0x00
};

/** 2D array presenting the launcherImage */
lc4uint launcherImage[] = {
  0x18,
  0x18,
  0x18,
  0x18,
  0x18,
  0x3C,
  0x3C,
  0x24
};

lc4uint destroyedCityImage[] = {
  0x00,
  0x00,
  0x00,
  0x00,
  0x3C,
  0x3C,
  0x3C,
  0x3C
};

/** Array of targets that the incoming will target */
lc4uint targets[NUM_TARGETS];

/** City struct that consists of the x position and 2D array */
/** representing the city's image */
typedef struct {
  lc4bool isDestroyed;
  lc4uint x;
  lc4uint cityImage[8];
}City;

/** Array consisting of cities */
City cities[NUM_CITIES];

/** Missile launcher struct that consists of the number missiles */
/** that the launcher has left, its x position and 2D array */
/** representing the missile launcher's image */
typedef struct {
  lc4bool isDestroyed;
  int missilesLeft;
  int x;
  lc4uint launcherImage[8];
}MissileLauncher;

/** Instance of the MissileLauncher Struct */
MissileLauncher missileLauncher;

/************************************************
 *  Projectile Struct
 *  lc4bool isActive - boolean representing 
 *                     if the projectile 
 *                     is active or not
 *  x0 - keeps track of its x starting position
 *  y0 - keeps track of its y starting position
 *  xnext - keeps track of its next x position
 *  ynext - keeps track of its next y position
 *  xend - keeps track of its ending x position
 *  yend - keeps track of its x ending position
 *  offset - keeps track of offset in the processNextPosition function
 ***********************************************/
typedef struct {
  lc4bool isActive;
  int x0;
  int y0;
  int xnext;
  int ynext;
  int xend;
  int yend;
  int offset;
}Projectile;

/** Array consisting of missiles on the screen */
Projectile outgoing[MAX_OUTGOING];

/** Array consisting of incoming on the screen */
Projectile incoming[MAX_INCOMING];

/** Cursor struct consisting of the cursor's x and y position */
typedef struct{
  int x;
  int y;
}Cursor;

/** Instance of the cursor*/
Cursor cursor;

/***************************************************************
 * Debugging and utility functions
 * DO NOT EDIT
 ***************************************************************/

/************************************************
 *  Printnum - Prints out the value on the lc4
 ***********************************************/
void printnum (int n) {
  int abs_n;
  char str[10], *ptr;

  // Corner case (n == 0)
  if (n == 0) {
    lc4_puts ((lc4uint*)"0");
    return;
  }
 
  abs_n = (n < 0) ? -n : n;

  // Corner case (n == -32768) no corresponding +ve value
  if (abs_n < 0) {
    lc4_puts ((lc4uint*)"-32768");
    return;
  }

  ptr = str + 10; // beyond last character in string

  *(--ptr) = 0; // null termination

  while (abs_n) {
    *(--ptr) = (abs_n % 10) + 48; // generate ascii code for digit
    abs_n /= 10;
  }

  // Handle -ve numbers by adding - sign
  if (n < 0) *(--ptr) = '-';

  lc4_puts((lc4uint*)ptr);
}

void endl () {
  lc4_puts((lc4uint*)"\n");
}

/************************************************
 *  abs - returns the absolute value
 ***********************************************/
int abs(int value)
{
  if(value < 0)
    return -value;
  return value;
}

/************************************************
 *  rand16 - This function returns a random 
 *  number between 0 and 128
 ***********************************************/
int rand16 ()
{
  int lfsr;

  // Advance the lfsr seven times
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();
  lfsr = lc4_lfsr();

  // return the last 7 bits
  return (lfsr & 0x7F);
}

int numMissiles = MISSILES_PER_ROUND;

/***************************************************************
 * End of Debugging and utility functions
 ***************************************************************/

/************************************************
 * DrawCursor - 
 * Draws the cursor sprite in white 
 ***********************************************/
 void DrawCursor() 
 {
  lc4_draw_sprite(cursor.x, cursor.y, WHITE, cursorImage);
 }

/************************************************
 *  DrawMissileLauncher - 
 *  Draws the missile launcher in white based on 
 *  the number of missiles left
 ***********************************************/
 void DrawMissileLauncher()
 {
  // checks if the missile launcher is destroyed
  if(missileLauncher.isDestroyed == 0) { 
    int i, y_even, y_odd;
    y_even = 0;
    y_odd = 0;
    // loops and draws the number of missiles that are left
    for(i = 0; i < missileLauncher.missilesLeft; i++) {
      // checks if the missile to be drawn is on the left or right side
      if(i % 2 == 0) { 
        // draws missiles on the left side of the launcher
        lc4_draw_sprite(MISSILE_COMMAND_XPOS - 5, GROUND_LEVEL + y_even, WHITE, missileLauncher.launcherImage); 
        // decrements so the missiles are drawn on top of each other
        y_even -= 5; 
      }
      else {
        // draws missiles on the right side of the launcher
        lc4_draw_sprite(MISSILE_COMMAND_XPOS + 5, GROUND_LEVEL + y_odd, WHITE, missileLauncher.launcherImage);  
        // decrements so the missiles are drawn on top of each other
        y_odd -= 5; 
      }
    }
  }
 }

/************************************************
 *  DrawCities - 
 *  Draws the cities in white
 ***********************************************/
 void DrawCities()
 {
  // checks if the left city is destroyed
  if(cities[0].isDestroyed == 0) {
    // draws not-destroyed left city image
    lc4_draw_sprite(LEFT_CITY_XPOS, GROUND_LEVEL, RED, cities[0].cityImage);
  }
  else {
    // draws destroyed left city image
    lc4_draw_sprite(LEFT_CITY_XPOS, GROUND_LEVEL, RED, destroyedCityImage);
  }
    // checks if the right city is destroyed
  if(cities[1].isDestroyed == 0) {
    // draws not-destroyed right city image
    lc4_draw_sprite(RIGHT_CITY_XPOS, GROUND_LEVEL, RED, cities[1].cityImage);
  }
  else {
    // draws destroyed right city image
    lc4_draw_sprite(RIGHT_CITY_XPOS, GROUND_LEVEL, RED, destroyedCityImage);
  }
 }
 /************************************************
 *  endpoint - 
 *  Helper function that determines which city/missile launcher is the incoming missile's destination
 ***********************************************/

  void endpoint(Projectile* p) {
    int k;
      k = rand16();
      // if k is divisible by 3, target the left city if it is not destroyed.  If it is destroyed, check the right city and then the missile launcher
      if(k % 3 == 0) {
        if(cities[0].isDestroyed == 0) {
          p->xend = LEFT_CITY_XPOS;
        }
        else if(cities[1].isDestroyed == 0) {
          p->xend = RIGHT_CITY_XPOS;
        }
        else {
          p->xend = MISSILE_COMMAND_XPOS;
        }
      }
      // if k % 3 == 1, target the right city if it is not destroyed.  If it is destroyed, check the left city and then the missile launcher
      else if(k % 3 == 1) {
        if(cities[1].isDestroyed == 0) {
          p->xend = RIGHT_CITY_XPOS;
        }
        else if(cities[0].isDestroyed == 0) {
          p->xend = LEFT_CITY_XPOS;
        }
        else {
          p->xend = MISSILE_COMMAND_XPOS;
        }
      }
      // if k % 3 == 0, target the missile launcher if it is not destroyed.  If it is destroyed, check the left city and then the right city.
      else if(k % 3 == 2) {
        if(missileLauncher.isDestroyed == 0) {
          p->xend = MISSILE_COMMAND_XPOS;
        }
        else if(cities[0].isDestroyed == 0) {
          p->xend = LEFT_CITY_XPOS;
        }
        else if(cities[1].isDestroyed == 0) {
          p->xend = RIGHT_CITY_XPOS;
        }
        else {
          p->xend = MISSILE_COMMAND_XPOS;
        }
      }
 }

/************************************************
 *  DrawIncoming - 
 *  Draws each incoming 
 ***********************************************/
 void DrawIncoming()
 {
  int i, j, k;
  for(i = 0; i < MAX_INCOMING; i++) {
    // checks if the incoming missile is active.  If not, make it active, determine its enedpoints with the helper function, and draw the first point.
    if(incoming[i].isActive == 0) {
      j = rand16();
      endpoint(&incoming[i]);
      lc4_draw_line(incoming[i].x0, incoming[i].y0, incoming[i].x0, incoming[i].y0, YELLOW);
      incoming[i].isActive = 1;
    }
    else {
      // if the incoming missile is active, draw the line
      lc4_draw_line(incoming[i].x0, incoming[i].y0, incoming[i].xnext, incoming[i].ynext, YELLOW);
      // once the incoming missile reaches its destination, change the sprite of the cities/launcher that it hits if appropriate
      if(incoming[i].xnext == incoming[i].xend && incoming[i].ynext == incoming[i].yend) {
        if(incoming[i].xend == LEFT_CITY_XPOS) {
          cities[0].isDestroyed = 1;
        }
        else if(incoming[i].xend == RIGHT_CITY_XPOS) {
          cities[1].isDestroyed = 1;
        }
        else if(incoming[i].xend == MISSILE_COMMAND_XPOS) {
          missileLauncher.isDestroyed = 1;
        }
        // reset the incoming missile
        incoming[i].isActive = 0;
        incoming[i].offset = 0;
      }
    }
  }
 }

/************************************************
 *  DrawOutgoing - 
 *  Draws each outgoing missile 
 ***********************************************/
 void DrawOutgoing()
 {
  int i, j, x_diff, y_diff;
  for(i = 0; i < MAX_OUTGOING; i++) {
    // checks if the outgoing missile is active and if there are still missiles left to be shot
    if(outgoing[i].isActive == 1 && missileLauncher.missilesLeft >= 0) {
       lc4_draw_line(outgoing[i].x0, outgoing[i].y0, outgoing[i].xnext, outgoing[i].ynext, GREEN);

       // once the outgoing missile reaches its destination, check if any incoming missiles are within CONTACT_RADIUS
       if(outgoing[i].xnext == outgoing[i].xend && outgoing[i].ynext == outgoing[i].yend) {
        for(j = 0; j < MAX_INCOMING; j++) {
          // distance formula to check if the outgoing's coordinates lie within CONTACT_RADIUS
          x_diff = (outgoing[i].xnext - incoming[j].xnext) * (outgoing[i].xnext - incoming[j].xnext);
          y_diff = (outgoing[i].ynext - incoming[j].ynext) * (outgoing[i].ynext - incoming[j].ynext);

          if(x_diff + y_diff <= CONTACT_RADIUS) {
            // decrease numMissiles and resets the incoming missile that was within CONTACAT_RADIUS
            numMissiles--;
            incoming[j].isActive = 0;
            incoming[j].offset = 0;
          }
        }
        // resets the outgoing missile
        outgoing[i].isActive = 0;
        outgoing[i].offset = 0;
       }
    }
  }
 }

/************************************************
 *  processNextIncomingPosition - 
 *  Uses Bresenham algorithm to calculate each point of the incoming missile
 ***********************************************/
 void processNextIncomingPosition(Projectile* p) 
 {
    int x0, x1, y0, y1, st, deltax, deltay, error, y, ystep, x, updateOffSet;
    x0 = p->x0;
    y0 = p->y0;
    x1 = p->xend;
    y1 = p->yend;

    if(abs(y1 - y0) > abs(x1 - x0)) {
      st = 1;
    }
    else {
      st = 0;
    }

    if(st == 1) {
      // swap(x0, y0)
      x0 = x0 - y0;
      y0 = x0 + y0;
      x0 = y0 - x0;

      // swap(x1, y1)
      x1 = x1 - y1;
      y1 = x1 + y1;
      x1 = y1 - x1;
    }

    if(x0 > x1) {
      // swap(x0, x1)
      x0 = x0 - x1;
      x1 = x0 + x1;
      x0 = x1 - x0;

      // swap(y0, y1)
      y0 = y0 - y1;
      y1 = y0 + y1;
      y0 = y1 - y0;
    }

    deltax = x1 - x0;
    deltay = abs(y1 - y0);
    error = 0;
    y = y0;

    if(y0 < y1) {
      ystep = 1;
    }
    else {
      ystep = -1;
    }

    // checks if the next pixel has been drawn
    updateOffSet = 0;

    for(x = x0; x <= x1; x++) {
      if(x0 + p->offset > x1) {
        p->xnext = p->xend;
        p->ynext = p->yend;
        break;
      }
      // checks if a pixel has been drawn 
      if(updateOffSet == 0) {
        // draws the pixel at x0 + p->offset
        if(st == 1 && x == x0 + p->offset) {
          // sets the next pixel's coordinates
          p->xnext = y;
          p->ynext = x;
          // sets the line's speed at 2
          p->offset += 2;
          // increments updateOffSet to signify that the pixel has been drawn and to not draw any more pixels
          updateOffSet = 1;
        }
        // draws the pixel at x0 + p->offset
        else if(st == 0 && x == x0 + p->offset) {
          // sets the next pixel's coordinates
          p->xnext = x;
          p->ynext = y;
          // sets the line's speed at 2
          p->offset += 2;
          // increments updateOffSet to signify that the pixel has been drawn and to not draw any more pixels
          updateOffSet = 1;
         }
       }

       error = error + deltay;

       if(2 * error >= deltax) {
         y = y + ystep;
         error = error - deltax;
       }
     }
 }

 /************************************************
 *  processNextOutgoingPosition - 
 *  Uses Bresenham algorithm to calculate each point of the outgoing missile
 ***********************************************/

  void processNextOutgoingPosition(Projectile* p) 
 {
    int x0, x1, y0, y1, st, deltax, deltay, error, y, ystep, x, updateOffSet, hasSwap;
    hasSwap = 0;
    x0 = p->x0;
    y0 = p->y0;
    x1 = p->xend;
    y1 = p->yend;

    if(abs(y1 - y0) > abs(x1 - x0)) {
      st = 1;
    }
    else {
      st = 0;
    }

    if(st == 1) {
      // swap(x0, y0)
      x0 = x0 - y0;
      y0 = x0 + y0;
      x0 = y0 - x0;

      // swap(x1, y1)
      x1 = x1 - y1;
      y1 = x1 + y1;
      x1 = y1 - x1;
    }

    if(x0 > x1) {
      hasSwap = 1;
      // swap(x0, x1)
      x0 = x0 - x1;
      x1 = x0 + x1;
      x0 = x1 - x0;

      // swap(y0, y1)
      y0 = y0 - y1;
      y1 = y0 + y1;
      y0 = y1 - y0;
    }

    deltax = x1 - x0;
    deltay = abs(y1 - y0);
    error = 0;
    y = y0;

    if(y0 < y1) {
      ystep = 1;
    }
    else {
      ystep = -1;
    }

    // checks if the next pixel has been drawn
    updateOffSet = 0;

      for(x = x0; x <= x1; x++) {
        if(x1 - p->offset < x0) {
          p->xnext = p->xend;
          p->ynext = p->yend;
          break;
        }
        // checks if a pixel has been drawn
        if(updateOffSet == 0) {
          // draws the pixel at x0 + p->offset
         if(st == 1 && x == x1 - p->offset) {
          // sets the next pixel's coordinates
          p->xnext = y;
          p->ynext = x;
          // sets the line's speed at 4
          p->offset += 4;
          // increments updateOffSet to signify that the pixel has been drawn and to not draw any more pixels
          updateOffSet = 1;
         }
         // draws the pixel at x0 + p->offset
        else if(st == 0 && x == x1 - p->offset && hasSwap == 1) {
          // sets the next pixel's coordinates
          p->xnext = x;
          p->ynext = y;
          // sets the line's speed at 4
          p->offset += 4;
          // increments updateOffSet to signify that the pixel has been drawn and to not draw any more pixels
          updateOffSet = 1;
         }
         // draws the pixel at x0 + p->offset
         else if(st == 0 && x == x0 + p->offset && hasSwap == 0) {
          // sets the next pixel's coordinates
          p->xnext = x;
          p->ynext = y;
          // sets the line's speed at 3
          p->offset += 3;
          updateOffSet = 1;
          // increments updateOffSet to signify that the pixel has been drawn and to not draw any more pixels
         }
        }

        error = error + deltay;

        if(2 * error >= deltax) {
          y = y + ystep;
          error = error - deltax;
        }
      }
 }

/************************************************
 *  Redraw - 
 *  Assuming that the PennSim is run with double 
 *  buffered mode, (using the launcher -> 
 *  (java -jar PennSim.jar -d))
 *  First, we should clear the video memory buffer 
 *  using lc4_reset_vmem.  Then we draw the scene 
 *  and then swap the video memory buffer using 
 *  lc4_blt_vmem
 ***********************************************/
void Redraw()
{
  lc4_reset_vmem();

  DrawCursor();
  DrawMissileLauncher();
  DrawCities();
  DrawOutgoing();
  DrawIncoming();
  lc4_blt_vmem();
}

/************************************************
 *  Reset - 
 *  Clears the screen
 ***********************************************/
void reset()
{
  lc4_reset_vmem();
  lc4_blt_vmem();
}

/************************************************
 *  ResetGame - 
 *  Resets the game. 
 ***********************************************/

 void ResetGame()
 {
  int i, j, k;    

  // sets the number of missiles shot to MISSILES_PER_ROUND
  numMissiles = MISSILES_PER_ROUND;

  cursor.x = 40;
  cursor.y = 60;
  DrawCursor();

  missileLauncher.missilesLeft = 8; // reset the missile launcher to have 8 missiles
  missileLauncher.isDestroyed = 0;  // missile launcher is not destroyed
  // draws missile launcher
  missileLauncher.launcherImage[0] = 0x18;
  missileLauncher.launcherImage[1] = 0x18;
  missileLauncher.launcherImage[2] = 0x18;
  missileLauncher.launcherImage[3] = 0x18;
  missileLauncher.launcherImage[4] = 0x18;
  missileLauncher.launcherImage[5] = 0x3C;
  missileLauncher.launcherImage[6] = 0x3C;
  missileLauncher.launcherImage[7] = 0x24;
  DrawMissileLauncher();

  cities[0].isDestroyed = 0; // reset the left city to not destroyed
  cities[0].x = LEFT_CITY_XPOS; // initialize the left city's position
  // draws the left city
  cities[0].cityImage[0] = 0x08;
  cities[0].cityImage[1] = 0x08;
  cities[0].cityImage[2] = 0x18;
  cities[0].cityImage[3] = 0x18;
  cities[0].cityImage[4] = 0x3C;
  cities[0].cityImage[5] = 0x3C;
  cities[0].cityImage[6] = 0x7E;
  cities[0].cityImage[7] = 0x7E;

  cities[1].isDestroyed = 0; // reset the right city to not destroyed
  cities[1].x = RIGHT_CITY_XPOS; // initialize the right city's position
  // draws the right city
  cities[1].cityImage[0] = 0x08;
  cities[1].cityImage[1] = 0x08;
  cities[1].cityImage[2] = 0x18;
  cities[1].cityImage[3] = 0x18;
  cities[1].cityImage[4] = 0x3C;
  cities[1].cityImage[5] = 0x3C;
  cities[1].cityImage[6] = 0x7E;
  cities[1].cityImage[7] = 0x7E;
  DrawCities();

  for(k = 0; k < MAX_OUTGOING; k++) {
    // sets the outgoing missile to shoot from the missile launcher
    outgoing[k].x0 = MISSILE_COMMAND_XPOS;
    outgoing[k].y0 = GROUND_LEVEL;
    outgoing[k].xnext = MISSILE_COMMAND_XPOS;
    outgoing[k].ynext = GROUND_LEVEL;
    outgoing[k].xend = cursor.x;
    outgoing[k].yend = cursor.y;
    outgoing[k].isActive = 0;
  }
  DrawOutgoing();

  for(i = 0; i < MAX_INCOMING; i++) {
    // sets each incoming missile to a random location in the sky
    j = rand16();
    incoming[i].x0 = j;
    incoming[i].y0 = 0;
    incoming[i].xnext = j;
    incoming[i].ynext = 0;
    incoming[i].xend = GROUND_LEVEL;
    incoming[i].yend = 115;
    incoming[i].isActive = 0;
  }
  DrawIncoming(); 
 }

/************************************************
 *  main - 
 *  Initalize game state by reseting the game state
 *  Loops until the the user loses
 ***********************************************/
 int main ()
 {
  //** Print to screen and initalize game state. */
  lc4_puts ((lc4uint*)"Welcome to Missile Command!\n");
  lc4_puts ((lc4uint*)"Press r to shoot a missile.\n");
  lc4_puts ((lc4uint*)"Press w, a, s and d to move the cursor.\n");

  ResetGame();

  while(1) 
  {
    int input;
    int i, j;

    input = lc4_getc_timer(GETC_TIMER_DELAY);
    if(input == 0x77) { // if 'w' is pressed
      cursor.y -= 5;
    }
    else if(input == 0x61) { // if 'a' is pressed
      cursor.x -= 5;
    }
    else if(input == 0x73) { // if 's' is pressed
      cursor.y += 5;
    }
    else if(input == 0x64) { // if 'd' is pressed
      cursor.x += 5;
    }
    else if(input == 0x72) { // if 'r' is pressed
      if(outgoing[0].isActive == 0) {
        outgoing[0].isActive = 1;
        outgoing[0].xnext = MISSILE_COMMAND_XPOS;
        outgoing[0].ynext = GROUND_LEVEL;
        outgoing[0].xend = cursor.x;
        outgoing[0].yend = cursor.y; 
        // decreases the number of missiles that are left in the launcher
        missileLauncher.missilesLeft--;
      }
    }

    Redraw();
    // processes next pixel of the incoming missile
    for(i = 0; i < MAX_INCOMING; i++) {
      if(incoming[i].isActive == 1) {
        processNextIncomingPosition(&incoming[i]);
      }
    }

    // processes next pixel of the outgoing missile
    for(j = 0; j < MAX_OUTGOING; j++) {
      if(outgoing[j].isActive == 1) {
        processNextOutgoingPosition(&outgoing[j]);
      }
    }

    // if 8 missiles have been destroyed, reset the game
    if(numMissiles <= 0) {
      ResetGame();
    }

    // if both cities have been destroyed, reset the game
    if(cities[0].isDestroyed == 1 && cities[1].isDestroyed == 1) {
      lc4_puts ((lc4uint*)"Game Over!\n");
      Reset();
      break;
    }
  }
  return 0;
}

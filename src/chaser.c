#include <stdlib.h>
#include "chaser.h"

#if defined(__AVR__)
#include <math.h>
const double SINPIPER8 = sin( PI_PER8 );
const double SINPIPER8TIMES3 = sin( PI_PER8 * (double)3 );
#define FUNCINLINE inline
#define RANGERANDOM(a,b)  (random() % ((b-a)+a))
#define SQRT sqrt

#elif defined(PBL_SDK_3)
#include <pebble.h>
#define SIN(r) (((float)sin_lookup(r * (TRIG_MAX_ANGLE / 360))) * (TRIG_MAX_ANGLE / 360))
#define SINPIPER8  ((double)(SIN( PI_PER8 )))
#define SINPIPER8TIMES3 ((double)(SIN( PI_PER8 * (double)3 )))
#define FUNCINLINE
#define RANGERANDOM(a,b)  (rand() % ((b-a)+a))
#define M_PI 3.14159265358979323846
#define SQRT pebblesqrt
float pebblesqrt(float num);

#else
#include <math.h>
#define SINPIPER8  ((double)(sin( PI_PER8 )))
#define SINPIPER8TIMES3 ((double)(sin( PI_PER8 * (double)3 )))
#define FUNCINLINE
#define RANGERANDOM(a,b)  (random() % ((b-a)+a))
#define SQRT sqrt
#endif

// ################################################################
// generate artificial pointer changes.
void randompointer(chaser *c){
  if ((RANGERANDOM(0,1000)<=25) || (c->pointer.x==-1 && c->pointer.y==-1)) { 
    c->pointer.x=RANGERANDOM(c->box.ul.x,c->box.lr.x);
    c->pointer.y=RANGERANDOM(c->box.ul.y,c->box.lr.y);
  }
}

// ################################################################
FUNCINLINE void chasertickcount(chaser *c) {
  if ( ++(c->tickcount) >= MAX_TICK ) {
    c->tickcount = 0;
  }

  if ( c->tickcount % 2 == 0 ) {
    if ( c->statecount < MAX_TICK ) {
      (c->statecount)++;
    }
  }
}

FUNCINLINE void setchaserstate(chaser *c, uint8_t state) {
  c->tickcount = 0;
  c->statecount = 0;
  c->state = state;
}

bool isoutsidedisplay(chaser *c) {
  bool value = false;

  if ( c->y <= c->box.ul.y ) {
    c->y = c->box.ul.y;
    value = true;
  } else if ( c->y >= c->box.lr.y) {
    c->y = c->box.lr.y; 
    value = true;
  }

  if ( c->x <= c->box.ul.y ) {
    c->x = c->box.ul.x;
    value = true;
  } else if ( c->x >= c->box.lr.x) {
    c->x = c->box.lr.x;
    value = true;
  }

  return(value);
}

FUNCINLINE bool ischaserdontmove(chaser *c){
  if ( (c->x == c->lastx) && (c->y == c->lasty) ) {
    return( true );
  } else {
    return( false );
  }
}

FUNCINLINE bool ischasermovestart(chaser *c) {
  if ( (c->movedx == 0) && (c->movedy == 0) ) {
    return( false );
  } else {
    return( true );
  }
}

FUNCINLINE void chaserdirection(chaser *c) {
  uint8_t	newstate;
  
  double	largex, largey;
  double	length;
  double	sintheta;

  if ( c->movedx == 0 && c->movedy == 0 ) {
    newstate = CHASER_STOP;
  } else {
    largex = (double)c->movedx;
    largey = (double)(-(c->movedy));
    length = SQRT( largex * largex + largey * largey );
    sintheta = largey / length;

    if ( c->movedx > 0 ) {
      if (sintheta > SINPIPER8TIMES3) {
        newstate = CHASER_U_MOVE;
      } else if ( (sintheta <= SINPIPER8TIMES3) && (sintheta > SINPIPER8) ) {
        newstate = CHASER_UR_MOVE;
      } else if ( (sintheta <= SINPIPER8)       && (sintheta > -(SINPIPER8)) ) {
        newstate = CHASER_R_MOVE;
      } else if ( (sintheta <= -(SINPIPER8))    && (sintheta > -(SINPIPER8TIMES3)) ) {
        newstate = CHASER_DR_MOVE;
      } else {
        newstate = CHASER_D_MOVE;
      }
    } else {
      if (sintheta > SINPIPER8TIMES3) {
        newstate = CHASER_U_MOVE;
      } else if ( (sintheta <= SINPIPER8TIMES3) && (sintheta > SINPIPER8) ) {
        newstate = CHASER_UL_MOVE;
      } else if ( (sintheta <= SINPIPER8)       && (sintheta > -(SINPIPER8)) ) {
        newstate = CHASER_L_MOVE;
      } else if ( (sintheta <= -(SINPIPER8))    && (sintheta > -(SINPIPER8TIMES3)) ) {
        newstate = CHASER_DL_MOVE;
      } else {
        newstate = CHASER_D_MOVE;
      }
    }
  }

  if ( c->state != newstate ) {
    setchaserstate(c, newstate);
  }
}

// ----------------------------------------------------------------
FUNCINLINE void calcdxdy(chaser *c) {
  double	largex, largey;
  double	doublelength, length;

  randompointer(c);
  
  //  largex = (double)( c->pointer.x - c->x - BITMAP_WIDTH / 2 );
  //largey = (double)( c->pointer.y - c->y - BITMAP_HEIGHT );
  largex = (double)( c->pointer.x - c->x );
  largey = (double)( c->pointer.y - c->y);

  doublelength = largex * largex + largey * largey;

  if ( doublelength != (double)0 ) {
    length = SQRT( doublelength );
    if ( length <= c->speed ) {
      c->movedx = (int16_t)largex;
      c->movedy = (int16_t)largey;
    } else {
      c->movedx = (int16_t)( ( c->speed * largex ) / length );
      c->movedy = (int16_t)( ( c->speed * largey ) / length );
    }
  } else {
    c->movedx = c->movedy = 0;
  }

}

void chaserthink(chaser *c) {
  calcdxdy(c);

  c->lastx=c->x;
  c->lasty=c->y;

  chasertickcount(c);

  switch ( c->state ) {
  case CHASER_STOP:
    //    if ( ischasermovestart(c) ) {
    //      setchaserstate(c, CHASER_AWAKE );
    //      break;
    //    }

    if ( c->statecount < CHASER_STOP_TIME ) {
      break;
    }

    if ( (c->movedx < 0) && (c->x <= c->box.ul.x) ) {
      setchaserstate(c, CHASER_L_TOGI );
    } else if ( (c->movedx > 0) && (c->x >= c->box.lr.x) ) {
      setchaserstate(c, CHASER_R_TOGI );
    } else if ( (c->movedy < 0) && (c->y <= c->box.ul.y) ) {
      setchaserstate(c, CHASER_U_TOGI );
    } else if ( (c->movedy > 0) && (c->y >= c->box.lr.y) ) {
      setchaserstate(c, CHASER_D_TOGI );
    } else {
      setchaserstate(c, CHASER_JARE );
    }
    break;
  case CHASER_JARE:
    if ( ischasermovestart(c) ) {
      setchaserstate(c, CHASER_AWAKE );
      break;
    }
    if ( c->statecount < CHASER_JARE_TIME ) {
      break;
    }
    setchaserstate(c, CHASER_KAKI );
    break;
  case CHASER_KAKI:
    if ( ischasermovestart(c) ) {
      setchaserstate(c, CHASER_AWAKE );
      break;
    }
    if ( c->statecount < CHASER_KAKI_TIME ) {
      break;
    }
    setchaserstate(c, CHASER_AKUBI );
    break;
  case CHASER_AKUBI:
    if ( ischasermovestart(c) ) {
      setchaserstate(c, CHASER_AWAKE );
      break;
    }
    if ( c->statecount < CHASER_AKUBI_TIME ) {
      break;
    }
    setchaserstate(c, CHASER_SLEEP );
    break;
  case CHASER_SLEEP:
    if ( ischasermovestart(c) ) {
      setchaserstate(c, CHASER_AWAKE );
      break;
    }
    break;
  case CHASER_AWAKE:
    if ( c->statecount < CHASER_AWAKE_TIME ) {
      break;
    }
    chaserdirection(c);
    break;
  case CHASER_U_MOVE:
  case CHASER_D_MOVE:
  case CHASER_L_MOVE:
  case CHASER_R_MOVE:
  case CHASER_UL_MOVE:
  case CHASER_UR_MOVE:
  case CHASER_DL_MOVE:
  case CHASER_DR_MOVE:
    c->x += c->movedx;
    c->y += c->movedy;
    chaserdirection(c);
    if ( isoutsidedisplay(c) ) {
      if ( ischaserdontmove(c) ) {
        setchaserstate(c, CHASER_STOP);
      }
    }
    break;
  case CHASER_U_TOGI:
  case CHASER_D_TOGI:
  case CHASER_L_TOGI:
  case CHASER_R_TOGI:
    //    if ( ischasermovestart(c) ) {
    //      setchaserstate(c, CHASER_AWAKE );
    //      break;
    //    }
    if ( c->statecount < CHASER_TOGI_TIME ) {
      break;
    }
    setchaserstate(c, CHASER_KAKI );
    break;
  default:
    /* Internal Error */
    setchaserstate(c, CHASER_STOP );
    break;
  }
}

void setupchaser(chaser *c, boundingbox box) {
  c->eventstate = NORMAL_STATE;

  //  c->x = (display_width /2.0) - (BITMAP_WIDTH /2.0);
  //  c->y = (display_height/2.0) - (BITMAP_HEIGHT/2.0);

  c->x = ((box.lr.x-box.ul.x) /2.0);
  c->y = ((box.lr.y-box.ul.y) /2.0);

  c->lastx=c->x;
  c->lasty=c->y;
  c->pointer.x=-1;
  c->pointer.y=-1;

  c->box=box;
  
  c->speed = (double)CHASER_SPEED;
  setchaserstate(c, CHASER_STOP);
}

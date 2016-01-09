#ifndef _CHASER_H_
#define	_CHASER_H_

#include <stdint.h>
#include <stdbool.h>

#if defined(PBL_SDK_3)
#else
#include <math.h>
#endif

#include <stdlib.h>

//----------------------------------------------------------------
#define	PI_PER8			((double)M_PI/(double)8)

#define	MAX_TICK		9999		/* Odd Only! */
#define	CHASER_SPEED		8

// states
#define	NORMAL_STATE		1

#define	CHASER_STOP		0
#define	CHASER_JARE		1
#define	CHASER_KAKI		2
#define	CHASER_AKUBI		3
#define	CHASER_SLEEP		4
#define	CHASER_AWAKE		5
#define	CHASER_U_MOVE		6
#define	CHASER_D_MOVE		7
#define	CHASER_L_MOVE		8
#define	CHASER_R_MOVE		9
#define	CHASER_UL_MOVE		10
#define	CHASER_UR_MOVE		11
#define	CHASER_DL_MOVE		12
#define	CHASER_DR_MOVE		13
#define	CHASER_U_TOGI		14
#define	CHASER_D_TOGI		15
#define	CHASER_L_TOGI		16
#define	CHASER_R_TOGI		17

//
#define	CHASER_STOP_TIME	4
#define	CHASER_JARE_TIME	10
#define	CHASER_KAKI_TIME	4
#define	CHASER_AKUBI_TIME	3
#define	CHASER_AWAKE_TIME	3
#define	CHASER_TOGI_TIME	10

//----------------------------------------------------------------
typedef struct {
  int16_t x;
  int16_t y;
} xycoord;

typedef struct {
  xycoord ul;
  xycoord lr;
} boundingbox;

typedef struct {
  uint8_t eventstate;
  uint8_t state;

  int16_t x;
  int16_t y;

  int16_t lastx;
  int16_t lasty;

  int16_t tickcount;
  int16_t statecount;

  int16_t movedx;
  int16_t movedy;

  boundingbox box;

  double speed;
  xycoord pointer;
} chaser;

//----------------------------------------------------------------
#endif

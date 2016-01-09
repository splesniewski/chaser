#ifndef	_PEBBLE_CHASER_H_
#define	_PEBBLE_CHASER_H_

#include "chaser.h"

typedef struct {
#if defined(PBL_COLOR)
  GBitmap* btm;
#else
  GBitmap* btm;
  GBitmap* msk;
#endif
} bitmapmask;

typedef struct {
#if defined(PBL_COLOR)
  BitmapLayer *btm;
#else
  BitmapLayer *btm;
  BitmapLayer *msk;
#endif
} chaserBitmapLayer;

//----------------
typedef struct {
  bitmapmask* tickeven;
  bitmapmask* tickodd;
} animation;

#endif

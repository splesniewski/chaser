#ifndef	_ARDUINO_ARDUIPI_OLED_CHASER_H_
#define	_ARDUINO_ARDUIPI_OLED_CHASER_H_
#include "chaser.h"

typedef struct {
  uint8_t *btm;
  uint8_t *msk;
  uint8_t width;
  uint8_t height;
} chaserimg;

typedef struct {
  chaserimg *tickeven;
  chaserimg *tickodd;
} animation;

#endif

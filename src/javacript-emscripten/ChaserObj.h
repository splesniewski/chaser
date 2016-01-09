#ifndef __CHASEROBJ_H__ 
#define __CHASEROBJ_H__ 

#include <chaser.h>

class ChaserObj {
public:
  chaser c;

  ChaserObj(boundingbox);
  ChaserObj(int16_t,int16_t,int16_t,int16_t);
  void think();
};

#endif

#include <iostream>
#include <chaser.h>
#include "ChaserObj.h"
using namespace std;

// ################################################################
extern "C" {
  void setupchaser(chaser *c, boundingbox b);
  void chaserthink(chaser *c);
}

ChaserObj::ChaserObj(boundingbox box) {
#if defined(DEBUG)
  cout << "new ChaserObj(1)" << endl
       << "ul_x:" << box.ul.x << endl
       << "ul_y:" << box.ul.y << endl
       << "lr_x:" << box.lr.x << endl
       << "lr_y:" << box.lr.y << endl
       << "===" << endl
    ;
#endif
  setupchaser(&c, box);
}

ChaserObj::ChaserObj(int16_t ul_x, int16_t ul_y, int16_t lr_x, int16_t lr_y) {
#if defined(DEBUG)
  cout << "new ChaserObj(2)" << endl
       << "ul_x:" << ul_x << endl
       << "ul_y:" << ul_y << endl
       << "lr_x:" << lr_x << endl
       << "lr_y:" << lr_y << endl
       << "===" << endl
    ;
#endif
  setupchaser(&c, (boundingbox){ .ul={.x=ul_x, .y=ul_y}, .lr={.x=lr_x, .y=lr_y} } );
}

void ChaserObj::think(){
  chaserthink(&c);
}

#ifdef __EMSCRIPTEN__
#include <emscripten/bind.h>
using namespace emscripten;

EMSCRIPTEN_BINDINGS(chaser) {
  //states
  constant("NORMAL_STATE", NORMAL_STATE);
  constant("CHASER_STOP", CHASER_STOP);
  constant("CHASER_JARE", CHASER_JARE);
  constant("CHASER_KAKI", CHASER_KAKI);
  constant("CHASER_AKUBI", CHASER_AKUBI);
  constant("CHASER_SLEEP", CHASER_SLEEP);
  constant("CHASER_AWAKE", CHASER_AWAKE);
  constant("CHASER_U_MOVE", CHASER_U_MOVE);
  constant("CHASER_D_MOVE", CHASER_D_MOVE);
  constant("CHASER_L_MOVE", CHASER_L_MOVE);
  constant("CHASER_R_MOVE", CHASER_R_MOVE);
  constant("CHASER_UL_MOVE", CHASER_UL_MOVE);
  constant("CHASER_UR_MOVE", CHASER_UR_MOVE);
  constant("CHASER_DL_MOVE", CHASER_DL_MOVE);
  constant("CHASER_DR_MOVE", CHASER_DR_MOVE);
  constant("CHASER_U_TOGI", CHASER_U_TOGI);
  constant("CHASER_D_TOGI", CHASER_D_TOGI);
  constant("CHASER_L_TOGI", CHASER_L_TOGI);
  constant("CHASER_R_TOGI", CHASER_R_TOGI);

  value_object<xycoord>("xycoord")
    .field("x",&xycoord::x)
    .field("y",&xycoord::y);

  value_object<boundingbox>("boundingbox")
    .field("x",&boundingbox::ul)
    .field("y",&boundingbox::lr);

  value_object<chaser>("chaser")
    .field("eventstate",&chaser::eventstate)
    .field("state",&chaser::state)
    .field("x",&chaser::x)
    .field("y",&chaser::y)
    .field("lastx",&chaser::lastx)
    .field("lasty",&chaser::lasty)
    .field("tickcount",&chaser::tickcount)
    .field("statecount",&chaser::statecount)
    .field("movedx",&chaser::movedx)
    .field("movedy",&chaser::movedy)
    .field("box", &chaser::box)
    .field("speed", &chaser::speed)
    .field("pointer", &chaser::pointer);

  class_<ChaserObj>("ChaserObj")
    .constructor<int16_t,int16_t,int16_t,int16_t>()
    .function("think", &ChaserObj::think)
    .property("c", &ChaserObj::c)
    ;
}
#endif

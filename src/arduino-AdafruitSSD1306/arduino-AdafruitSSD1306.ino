// -*- mode:c; indent-tabs-mode:nil; -*-
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#include "arduino-AdafruitSSD1306.h"
#include "chaser.h"

#define BITMAP_WIDTH (32)
#define BITMAP_HEIGHT (32)

// ################################################################
extern "C"{
  void setupchaser(chaser *c, boundingbox box);
  void chaserthink(chaser *c);
}

#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);

// AdaFruit library cannot determin display size so it must be set by hand
const uint16_t display_width=128;
const uint16_t display_height=64;

// ################################################################
// Any values over 1, the chasers will overlap.
#define NUMCHASER 3
chaser Chaser[NUMCHASER];

// ################################################################
#include "images_all.h"

chaserimg CIMG_jare2=    {(uint8_t *)b_jare2_btm,    (uint8_t *)b_jare2_msk,    b_jare2_width,    b_jare2_height};
chaserimg CIMG_mati2=    {(uint8_t *)b_mati2_btm,    (uint8_t *)b_mati2_msk,    b_mati2_width,    b_mati2_height};
chaserimg CIMG_kaki1=    {(uint8_t *)b_kaki1_btm,    (uint8_t *)b_kaki1_msk,    b_kaki1_width,    b_kaki1_height};
chaserimg CIMG_kaki2=    {(uint8_t *)b_kaki2_btm,    (uint8_t *)b_kaki2_msk,    b_kaki2_width,    b_kaki2_height};
chaserimg CIMG_mati3=    {(uint8_t *)b_mati3_btm,    (uint8_t *)b_mati3_msk,    b_mati3_width,    b_mati3_height};
chaserimg CIMG_sleep1=   {(uint8_t *)b_sleep1_btm,   (uint8_t *)b_sleep1_msk,   b_sleep1_width,   b_sleep1_height};
chaserimg CIMG_sleep2=   {(uint8_t *)b_sleep2_btm,   (uint8_t *)b_sleep2_msk,   b_sleep2_width,   b_sleep2_height};
chaserimg CIMG_awake=    {(uint8_t *)b_awake_btm,    (uint8_t *)b_awake_msk,    b_awake_width,    b_awake_height};

chaserimg CIMG_up1=      {(uint8_t *)b_up1_btm,      (uint8_t *)b_up1_msk,      b_up1_width,      b_up1_height};
chaserimg CIMG_up2=      {(uint8_t *)b_up2_btm,      (uint8_t *)b_up2_msk,      b_up2_width,      b_up2_height};
chaserimg CIMG_down1=    {(uint8_t *)b_down1_btm,    (uint8_t *)b_down1_msk,    b_down1_width,    b_down1_height};
chaserimg CIMG_down2=    {(uint8_t *)b_down2_btm,    (uint8_t *)b_down2_msk,    b_down2_width,    b_down2_height};
chaserimg CIMG_left1=    {(uint8_t *)b_left1_btm,    (uint8_t *)b_left1_msk,    b_left1_width,    b_left1_height};
chaserimg CIMG_left2=    {(uint8_t *)b_left2_btm,    (uint8_t *)b_left2_msk,    b_left2_width,    b_left2_height};
chaserimg CIMG_right1=   {(uint8_t *)b_right1_btm,   (uint8_t *)b_right1_msk,   b_right1_width,   b_right1_height};
chaserimg CIMG_right2=   {(uint8_t *)b_right2_btm,   (uint8_t *)b_right2_msk,   b_right2_width,   b_right2_height};

chaserimg CIMG_upleft1=  {(uint8_t *)b_upleft1_btm,  (uint8_t *)b_upleft1_msk,  b_upleft1_width,  b_upleft1_height};
chaserimg CIMG_upleft2=  {(uint8_t *)b_upleft2_btm,  (uint8_t *)b_upleft2_msk,  b_upleft2_width,  b_upleft2_height};
chaserimg CIMG_upright1= {(uint8_t *)b_upright1_btm, (uint8_t *)b_upright1_msk, b_upright1_width, b_upright1_height};
chaserimg CIMG_upright2= {(uint8_t *)b_upright2_btm, (uint8_t *)b_upright2_msk, b_upright2_width, b_upright2_height};
chaserimg CIMG_dwleft1=  {(uint8_t *)b_dwleft1_btm,  (uint8_t *)b_dwleft1_msk,  b_dwleft1_width,  b_dwleft1_height};
chaserimg CIMG_dwleft2=  {(uint8_t *)b_dwleft2_btm,  (uint8_t *)b_dwleft2_msk,  b_dwleft2_width,  b_dwleft2_height};
chaserimg CIMG_dwright1= {(uint8_t *)b_dwright1_btm, (uint8_t *)b_dwright1_msk, b_dwright1_width, b_dwright1_height};
chaserimg CIMG_dwright2= {(uint8_t *)b_dwright2_btm, (uint8_t *)b_dwright2_msk, b_dwright2_width, b_dwright2_height};

chaserimg CIMG_dtogi1=   {(uint8_t *)b_dtogi1_btm,   (uint8_t *)b_dtogi1_msk,   b_dtogi1_width,   b_dtogi1_height};
chaserimg CIMG_dtogi2=   {(uint8_t *)b_dtogi2_btm,   (uint8_t *)b_dtogi2_msk,   b_dtogi2_width,   b_dtogi2_height};
chaserimg CIMG_ltogi1=   {(uint8_t *)b_ltogi1_btm,   (uint8_t *)b_ltogi1_msk,   b_ltogi1_width,   b_ltogi1_height};
chaserimg CIMG_ltogi2=   {(uint8_t *)b_ltogi2_btm,   (uint8_t *)b_ltogi2_msk,   b_ltogi2_width,   b_ltogi2_height};
chaserimg CIMG_rtogi1=   {(uint8_t *)b_rtogi1_btm,   (uint8_t *)b_rtogi1_msk,   b_rtogi1_width,   b_rtogi1_height};
chaserimg CIMG_rtogi2=   {(uint8_t *)b_rtogi2_btm,   (uint8_t *)b_rtogi2_msk,   b_rtogi2_width,   b_rtogi2_height};
chaserimg CIMG_utogi1=   {(uint8_t *)b_utogi1_btm,   (uint8_t *)b_utogi1_msk,   b_utogi1_width,   b_utogi1_height};
chaserimg CIMG_utogi2=   {(uint8_t *)b_utogi2_btm,   (uint8_t *)b_utogi2_msk,   b_utogi2_width,   b_utogi2_height};

animation animationpattern[] = {
  { &CIMG_mati2,    &CIMG_mati2 },	/* state == CHASER_STOP */

  { &CIMG_jare2,    &CIMG_mati2 },	/* state == CHASER_JARE */
  { &CIMG_kaki1,    &CIMG_kaki2 },	/* state == CHASER_KAKI */
  { &CIMG_mati3,    &CIMG_mati3 },	/* state == CHASER_AKUBI */
  { &CIMG_sleep1,   &CIMG_sleep2 },	/* state == CHASER_SLEEP */
  { &CIMG_awake,    &CIMG_awake },	/* state == CHASER_AWAKE */

  { &CIMG_up1,      &CIMG_up2 },	/* state == CHASER_U_MOVE */
  { &CIMG_down1,    &CIMG_down2 },	/* state == CHASER_D_MOVE */
  { &CIMG_left1,    &CIMG_left2 },	/* state == CHASER_L_MOVE */
  { &CIMG_right1,   &CIMG_right2 },	/* state == CHASER_R_MOVE */

  { &CIMG_upleft1,  &CIMG_upleft2 },	/* state == CHASER_UL_MOVE */
  { &CIMG_upright1, &CIMG_upright2 },	/* state == CHASER_UR_MOVE */
  { &CIMG_dwleft1,  &CIMG_dwleft2 },	/* state == CHASER_DL_MOVE */
  { &CIMG_dwright1, &CIMG_dwright2 },	/* state == CHASER_DR_MOVE */

  { &CIMG_utogi1,   &CIMG_utogi2 },	/* state == CHASER_U_TOGI */
  { &CIMG_dtogi1,   &CIMG_dtogi2 },	/* state == CHASER_D_TOGI */
  { &CIMG_ltogi1,   &CIMG_ltogi2 },	/* state == CHASER_L_TOGI */
  { &CIMG_rtogi1,   &CIMG_rtogi2 },	/* state == CHASER_R_TOGI */
};

// ################################################################
// Arduino+Adafruit_SSD1306

inline void update(){
  for (uint8_t d=0; d<NUMCHASER; d++) { chaserthink(&Chaser[d]); }
}
void setup()   {
  // if analog input pin 0 is unconnected, random analog
  // noise will cause the call to randomSeed() to generate
  // different seed numbers each time the sketch runs.
  // randomSeed() will then shuffle the random function.
  randomSeed(analogRead(0));

  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  display.clearDisplay();
  
  for (uint8_t d=0; d<NUMCHASER; d++) { 
    setupchaser(
                &Chaser[d],
                (boundingbox){.ul={.x=0,.y=0},.lr={.x=(display_width-BITMAP_WIDTH),.y=(display_height-BITMAP_HEIGHT)}}
                );
  }

  // run the chasers through a few interation to put them in "random" spots.
  for (uint8_t n=0; n<50; n++) { update(); }
}

void loop() {
  update();

  display.fillRect(0, 0, display.width(), display.height(), WHITE);
  for (uint8_t d=0; d<NUMCHASER; d++) {
    chaser *c=&Chaser[d];
    chaserimg *cimg;

    if ( c->state != CHASER_SLEEP ) {
      cimg=((c->tickcount % 2 == 0 )?
            animationpattern[c->state].tickeven :
            animationpattern[c->state].tickodd );
    } else {
      cimg=((c->tickcount % 8 <= 3) ?
            animationpattern[c->state].tickeven :
            animationpattern[c->state].tickodd );
    }

    display.drawBitmap(c->x, c->y, cimg->msk, cimg->width, cimg->height, BLACK);
    display.drawBitmap(c->x, c->y, cimg->btm, cimg->width, cimg->height, WHITE);
  } 
  display.display();
  delay(100);
}

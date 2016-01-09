#include <pebble.h>

#include "chaser.h"
#include "pebble-chaser.h"

#define SCREEN_WIDTH (144)
#define SCREEN_HEIGHT (168)
#define BITMAP_WIDTH (32)
#define BITMAP_HEIGHT (32)

// ################################################################
void setupchaser(chaser *c, boundingbox box);
void chaserthink(chaser *c);

// ################################################################
// Any values over 1, the chasers will overlap.
#define NUMCHASER 3
chaser Chaser[NUMCHASER];

#define CHASERDELAY 240

// ################################################################
static Window *window;

static Layer *time_layer;
static TextLayer *time_textlayer;
static chaserBitmapLayer chasers_layers[NUMCHASER];

// ################################################################

bitmapmask CIMG_jare2;
bitmapmask CIMG_mati2;
bitmapmask CIMG_kaki1;
bitmapmask CIMG_kaki2;
bitmapmask CIMG_mati3;
bitmapmask CIMG_sleep1;
bitmapmask CIMG_sleep2;
bitmapmask CIMG_awake;

bitmapmask CIMG_up1;
bitmapmask CIMG_up2;
bitmapmask CIMG_down1;
bitmapmask CIMG_down2;
bitmapmask CIMG_left1;
bitmapmask CIMG_left2;
bitmapmask CIMG_right1;
bitmapmask CIMG_right2;

bitmapmask CIMG_upleft1;
bitmapmask CIMG_upleft2;
bitmapmask CIMG_upright1;
bitmapmask CIMG_upright2;
bitmapmask CIMG_dwleft1;
bitmapmask CIMG_dwleft2;
bitmapmask CIMG_dwright1;
bitmapmask CIMG_dwright2;

bitmapmask CIMG_dtogi1;
bitmapmask CIMG_dtogi2;
bitmapmask CIMG_ltogi1;
bitmapmask CIMG_ltogi2;
bitmapmask CIMG_rtogi1;
bitmapmask CIMG_rtogi2;
bitmapmask CIMG_utogi1;
bitmapmask CIMG_utogi2;

animation animationpattern[]={
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

void update(){
  for (uint8_t d=0; d<NUMCHASER; d++) { chaserthink(&Chaser[d]); }
}

void setup() {
  for (uint8_t d=0; d<NUMCHASER; d++) {
    setupchaser(
		&Chaser[d],
		(boundingbox){.ul={.x=0,.y=0},.lr={.x=(SCREEN_WIDTH-BITMAP_WIDTH),.y=(SCREEN_HEIGHT-BITMAP_HEIGHT)}}
		);
  }

  // run the chasers through a few interation to put them in a "random" spots.
  for (uint8_t n=0; n<50; n++) { update(); }
}

//################################################################
static char time_str[] = "HH MM ";
static void update_time (struct tm *t){
  if (clock_is_24h_style()) {
    strftime(time_str, sizeof(time_str), "%H-%M", t);
  }else{
    strftime(time_str, sizeof(time_str), "%I-%M", t);
  }
  text_layer_set_text(time_textlayer, time_str);
}

void handle_updatechaser() {
  for (uint8_t d=0; d<NUMCHASER; d++) {
    chaser *c=&Chaser[d];
    bitmapmask* canim;

    if ( c->state != CHASER_SLEEP ) {
      canim=((c->tickcount % 2 == 0 )?
	    animationpattern[c->state].tickeven :
	    animationpattern[c->state].tickodd );
    } else {
      canim=((c->tickcount % 8 <= 3) ?
	    animationpattern[c->state].tickeven :
	    animationpattern[c->state].tickodd );
    }

#if defined(PBL_COLOR)
    layer_set_frame(bitmap_layer_get_layer(chasers_layers[d].btm), ((GRect) { .origin = { c->x, c->y }, .size = { 32, 32 } } ));
    bitmap_layer_set_bitmap(chasers_layers[d].btm, canim->btm);

    layer_mark_dirty(bitmap_layer_get_layer(chasers_layers[d].btm));
#else
    layer_set_frame(bitmap_layer_get_layer(chasers_layers[d].msk), ((GRect) { .origin = { c->x, c->y }, .size = { 32, 32 } } ));
    bitmap_layer_set_bitmap(chasers_layers[d].msk, canim->msk);

    layer_set_frame(bitmap_layer_get_layer(chasers_layers[d].btm), ((GRect) { .origin = { c->x, c->y }, .size = { 32, 32 } } ));
    bitmap_layer_set_bitmap(chasers_layers[d].btm, canim->btm);

    layer_mark_dirty(bitmap_layer_get_layer(chasers_layers[d].msk));
    layer_mark_dirty(bitmap_layer_get_layer(chasers_layers[d].btm));
#endif

  }
  update();
  app_timer_register(CHASERDELAY, handle_updatechaser, NULL);
}

void handle_second_tick(struct tm *t, TimeUnits units_changed) {
  update_time(t);
}

//################################################################
static void window_load(Window *window) {
  Layer *window_layer = window_get_root_layer(window);
  //  GRect window_bounds = layer_get_bounds(window_layer);

  //----------------
#if defined(PBL_COLOR)
  window_set_background_color(window, GColorFromRGB(0x00, 0x80, 0x00));
#endif

  //----------------
  for (uint8_t d=0; d<NUMCHASER; d++) {
#if defined(PBL_COLOR)
    chasers_layers[d].btm=bitmap_layer_create((GRect) { .origin = { 0, 0 }, .size = {32,32} });
    bitmap_layer_set_compositing_mode(chasers_layers[d].btm, GCompOpSet);
    layer_add_child(window_layer, bitmap_layer_get_layer(chasers_layers[d].btm));
#else
    chasers_layers[d].msk=bitmap_layer_create((GRect) { .origin = { 0, 0 }, .size = {32,32} });
    bitmap_layer_set_compositing_mode(chasers_layers[d].msk, GCompOpSet);
    layer_add_child(window_layer, bitmap_layer_get_layer(chasers_layers[d].msk));

    chasers_layers[d].btm=bitmap_layer_create((GRect) { .origin = { 0, 0 }, .size = {32,32} });
    bitmap_layer_set_compositing_mode(chasers_layers[d].btm, GCompOpAnd);
    layer_add_child(window_layer, bitmap_layer_get_layer(chasers_layers[d].btm));
#endif
  }

  //----------------
  time_layer = layer_create((GRect) { .origin = {16, 0}, .size = {(SCREEN_WIDTH-(16*2)), 50 }});
  layer_add_child(window_layer, time_layer);

  time_textlayer = text_layer_create(layer_get_bounds(time_layer));
  text_layer_set_text_alignment(time_textlayer, GTextAlignmentCenter);
  text_layer_set_background_color(time_textlayer, GColorClear);
  text_layer_set_text_color(time_textlayer, COLOR_FALLBACK(GColorWhite, GColorBlack));
  text_layer_set_font(time_textlayer,fonts_get_system_font(FONT_KEY_GOTHIC_28));
  layer_add_child(time_layer, text_layer_get_layer(time_textlayer));

  //----------------
  time_t now= time(NULL);
  struct tm *t; 
  t = localtime(&now);
  update_time(t);

  //----------------
#if defined(PBL_COLOR)
  CIMG_jare2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_jare2);
  CIMG_mati2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_mati2);
  CIMG_kaki1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_kaki1);
  CIMG_kaki2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_kaki2);
  CIMG_mati3.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_mati3);
  CIMG_sleep1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_sleep1);
  CIMG_sleep2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_sleep2);
  CIMG_awake.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_awake);

  CIMG_up1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_up1);
  CIMG_up2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_up2);
  CIMG_down1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_down1);
  CIMG_down2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_down2);
  CIMG_left1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_left1);
  CIMG_left2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_left2);
  CIMG_right1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_right1);
  CIMG_right2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_right2);

  CIMG_upleft1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_upleft1);
  CIMG_upleft2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_upleft2);
  CIMG_upright1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_upright1);
  CIMG_upright2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_upright2);
  CIMG_dwleft1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_dwleft1);
  CIMG_dwleft2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_dwleft2);
  CIMG_dwright1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_dwright1);
  CIMG_dwright2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_dwright2);

  CIMG_dtogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_dtogi1);
  CIMG_dtogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_dtogi2);
  CIMG_ltogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_ltogi1);
  CIMG_ltogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_ltogi2);
  CIMG_rtogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_rtogi1);
  CIMG_rtogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_rtogi2);
  CIMG_utogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_utogi1);
  CIMG_utogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_CL_BTM_utogi2);
#else
  CIMG_jare2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_jare2);
  CIMG_mati2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_mati2);
  CIMG_kaki1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_kaki1);
  CIMG_kaki2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_kaki2);
  CIMG_mati3.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_mati3);
  CIMG_sleep1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_sleep1);
  CIMG_sleep2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_sleep2);
  CIMG_awake.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_awake);

  CIMG_up1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_up1);
  CIMG_up2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_up2);
  CIMG_down1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_down1);
  CIMG_down2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_down2);
  CIMG_left1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_left1);
  CIMG_left2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_left2);
  CIMG_right1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_right1);
  CIMG_right2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_right2);

  CIMG_upleft1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_upleft1);
  CIMG_upleft2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_upleft2);
  CIMG_upright1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_upright1);
  CIMG_upright2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_upright2);
  CIMG_dwleft1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_dwleft1);
  CIMG_dwleft2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_dwleft2);
  CIMG_dwright1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_dwright1);
  CIMG_dwright2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_dwright2);

  CIMG_dtogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_dtogi1);
  CIMG_dtogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_dtogi2);
  CIMG_ltogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_ltogi1);
  CIMG_ltogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_ltogi2);
  CIMG_rtogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_rtogi1);
  CIMG_rtogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_rtogi2);
  CIMG_utogi1.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_utogi1);
  CIMG_utogi2.btm=gbitmap_create_with_resource(RESOURCE_ID_C_BW_BTM_utogi2);

  CIMG_jare2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_jare2);
  CIMG_mati2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_mati2);
  CIMG_kaki1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_kaki1);
  CIMG_kaki2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_kaki2);
  CIMG_mati3.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_mati3);
  CIMG_sleep1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_sleep1);
  CIMG_sleep2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_sleep2);
  CIMG_awake.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_awake);

  CIMG_up1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_up1);
  CIMG_up2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_up2);
  CIMG_down1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_down1);
  CIMG_down2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_down2);
  CIMG_left1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_left1);
  CIMG_left2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_left2);
  CIMG_right1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_right1);
  CIMG_right2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_right2);

  CIMG_upleft1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_upleft1);
  CIMG_upleft2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_upleft2);
  CIMG_upright1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_upright1);
  CIMG_upright2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_upright2);
  CIMG_dwleft1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_dwleft1);
  CIMG_dwleft2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_dwleft2);
  CIMG_dwright1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_dwright1);
  CIMG_dwright2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_dwright2);

  CIMG_dtogi1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_dtogi1);
  CIMG_dtogi2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_dtogi2);
  CIMG_ltogi1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_ltogi1);
  CIMG_ltogi2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_ltogi2);
  CIMG_rtogi1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_rtogi1);
  CIMG_rtogi2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_rtogi2);
  CIMG_utogi1.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_utogi1);
  CIMG_utogi2.msk=gbitmap_create_with_resource(RESOURCE_ID_C_BW_MSK_utogi2);
#endif

  //----------------
  setup();

  //----------------
  tick_timer_service_subscribe(SECOND_UNIT, handle_second_tick);
  app_timer_register(CHASERDELAY, handle_updatechaser, NULL);
}

static void window_unload(Window *window) {
  tick_timer_service_unsubscribe();

  //----------------
#if defined(PBL_COLOR)
  gbitmap_destroy(CIMG_utogi2.btm);
  gbitmap_destroy(CIMG_utogi1.btm);
  gbitmap_destroy(CIMG_rtogi2.btm);
  gbitmap_destroy(CIMG_rtogi1.btm);
  gbitmap_destroy(CIMG_ltogi2.btm);
  gbitmap_destroy(CIMG_ltogi1.btm);
  gbitmap_destroy(CIMG_dtogi2.btm);
  gbitmap_destroy(CIMG_dtogi1.btm);

  gbitmap_destroy(CIMG_dwright2.btm);
  gbitmap_destroy(CIMG_dwright1.btm);
  gbitmap_destroy(CIMG_dwleft2.btm);
  gbitmap_destroy(CIMG_dwleft1.btm);
  gbitmap_destroy(CIMG_upright2.btm);
  gbitmap_destroy(CIMG_upright1.btm);
  gbitmap_destroy(CIMG_upleft2.btm);
  gbitmap_destroy(CIMG_upleft1.btm);

  gbitmap_destroy(CIMG_right2.btm);
  gbitmap_destroy(CIMG_right1.btm);
  gbitmap_destroy(CIMG_left2.btm);
  gbitmap_destroy(CIMG_left1.btm);
  gbitmap_destroy(CIMG_down2.btm);
  gbitmap_destroy(CIMG_down1.btm);
  gbitmap_destroy(CIMG_up2.btm);
  gbitmap_destroy(CIMG_up1.btm);

  gbitmap_destroy(CIMG_awake.btm);
  gbitmap_destroy(CIMG_sleep2.btm);
  gbitmap_destroy(CIMG_sleep1.btm);
  gbitmap_destroy(CIMG_mati3.btm);
  gbitmap_destroy(CIMG_kaki2.btm);
  gbitmap_destroy(CIMG_kaki1.btm);
  gbitmap_destroy(CIMG_mati2.btm);
  gbitmap_destroy(CIMG_jare2.btm);

#else
  gbitmap_destroy(CIMG_utogi2.msk);
  gbitmap_destroy(CIMG_utogi1.msk);
  gbitmap_destroy(CIMG_rtogi2.msk);
  gbitmap_destroy(CIMG_rtogi1.msk);
  gbitmap_destroy(CIMG_ltogi2.msk);
  gbitmap_destroy(CIMG_ltogi1.msk);
  gbitmap_destroy(CIMG_dtogi2.msk);
  gbitmap_destroy(CIMG_dtogi1.msk);

  gbitmap_destroy(CIMG_dwright2.msk);
  gbitmap_destroy(CIMG_dwright1.msk);
  gbitmap_destroy(CIMG_dwleft2.msk);
  gbitmap_destroy(CIMG_dwleft1.msk);
  gbitmap_destroy(CIMG_upright2.msk);
  gbitmap_destroy(CIMG_upright1.msk);
  gbitmap_destroy(CIMG_upleft2.msk);
  gbitmap_destroy(CIMG_upleft1.msk);

  gbitmap_destroy(CIMG_right2.msk);
  gbitmap_destroy(CIMG_right1.msk);
  gbitmap_destroy(CIMG_left2.msk);
  gbitmap_destroy(CIMG_left1.msk);
  gbitmap_destroy(CIMG_down2.msk);
  gbitmap_destroy(CIMG_down1.msk);
  gbitmap_destroy(CIMG_up2.msk);
  gbitmap_destroy(CIMG_up1.msk);

  gbitmap_destroy(CIMG_awake.msk);
  gbitmap_destroy(CIMG_sleep2.msk);
  gbitmap_destroy(CIMG_sleep1.msk);
  gbitmap_destroy(CIMG_mati3.msk);
  gbitmap_destroy(CIMG_kaki2.msk);
  gbitmap_destroy(CIMG_kaki1.msk);
  gbitmap_destroy(CIMG_mati2.msk);
  gbitmap_destroy(CIMG_jare2.msk);


  gbitmap_destroy(CIMG_utogi2.btm);
  gbitmap_destroy(CIMG_utogi1.btm);
  gbitmap_destroy(CIMG_rtogi2.btm);
  gbitmap_destroy(CIMG_rtogi1.btm);
  gbitmap_destroy(CIMG_ltogi2.btm);
  gbitmap_destroy(CIMG_ltogi1.btm);
  gbitmap_destroy(CIMG_dtogi2.btm);
  gbitmap_destroy(CIMG_dtogi1.btm);

  gbitmap_destroy(CIMG_dwright2.btm);
  gbitmap_destroy(CIMG_dwright1.btm);
  gbitmap_destroy(CIMG_dwleft2.btm);
  gbitmap_destroy(CIMG_dwleft1.btm);
  gbitmap_destroy(CIMG_upright2.btm);
  gbitmap_destroy(CIMG_upright1.btm);
  gbitmap_destroy(CIMG_upleft2.btm);
  gbitmap_destroy(CIMG_upleft1.btm);

  gbitmap_destroy(CIMG_right2.btm);
  gbitmap_destroy(CIMG_right1.btm);
  gbitmap_destroy(CIMG_left2.btm);
  gbitmap_destroy(CIMG_left1.btm);
  gbitmap_destroy(CIMG_down2.btm);
  gbitmap_destroy(CIMG_down1.btm);
  gbitmap_destroy(CIMG_up2.btm);
  gbitmap_destroy(CIMG_up1.btm);

  gbitmap_destroy(CIMG_awake.btm);
  gbitmap_destroy(CIMG_sleep2.btm);
  gbitmap_destroy(CIMG_sleep1.btm);
  gbitmap_destroy(CIMG_mati3.btm);
  gbitmap_destroy(CIMG_kaki2.btm);
  gbitmap_destroy(CIMG_kaki1.btm);
  gbitmap_destroy(CIMG_mati2.btm);
  gbitmap_destroy(CIMG_jare2.btm);
#endif
  //----------------
  text_layer_destroy(time_textlayer);
  layer_destroy(time_layer);

  for (uint8_t d=0; d<NUMCHASER; d++) {
#if defined(PBL_COLOR)
    bitmap_layer_destroy(chasers_layers[d].btm);
#else
    bitmap_layer_destroy(chasers_layers[d].msk);
    bitmap_layer_destroy(chasers_layers[d].btm);
#endif
  }
}

//################################################################
static void init(void) {
  window = window_create();
  window_set_window_handlers(window, (WindowHandlers) {
    .load = window_load,
    .unload = window_unload,
  });

  const bool animated = true;
  window_stack_push(window, animated);
}

static void deinit(void) {
  window_destroy(window);
}

int main(void) {
  init();

  // APP_LOG(APP_LOG_LEVEL_DEBUG, "Done initializing, pushed window: %p", window);

  app_event_loop();
  deinit();
}

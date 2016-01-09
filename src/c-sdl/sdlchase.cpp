#include <SDL.h>
#if SDL_MAJOR_VERSION == 2
#include <SDL_image.h>
#include <SDL_timer.h>
#elif SDL_MAJOR_VERSION == 1 || defined(__EMSCRIPTEN__)
#include <SDL_image.h>
#include <SDL_timer.h>
#else
#error "unsupported SDL version "
#endif

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include <stdio.h>
#include "sdlchase.h"

#define SCREEN_WIDTH (640)
#define SCREEN_HEIGHT (320)
#define BITMAP_WIDTH (32)
#define BITMAP_HEIGHT (32)

uint16_t display_width=SCREEN_WIDTH;
uint16_t display_height=SCREEN_HEIGHT;

// ################################################################
extern "C"{
  void setupchaser(chaser *c, boundingbox box);
  void chaserthink(chaser *c);
}
// ################################################################
// Any values over 1, the chasers will overlap.
#define NUMCHASER (8)
chaser Chaser[NUMCHASER];

// ################################################################

  SDL_Surface* CIMG_jare2=IMG_Load("img/jare2.png");
  SDL_Surface* CIMG_mati2=IMG_Load("img/mati2.png");
  SDL_Surface* CIMG_kaki1=IMG_Load("img/kaki1.png");
  SDL_Surface* CIMG_kaki2=IMG_Load("img/kaki2.png");
  SDL_Surface* CIMG_mati3=IMG_Load("img/mati3.png");
  SDL_Surface* CIMG_sleep1=IMG_Load("img/sleep1.png");
  SDL_Surface* CIMG_sleep2=IMG_Load("img/sleep2.png");
  SDL_Surface* CIMG_awake=IMG_Load("img/awake.png");

  SDL_Surface* CIMG_up1=IMG_Load("img/up1.png");
  SDL_Surface* CIMG_up2=IMG_Load("img/up2.png");
  SDL_Surface* CIMG_down1=IMG_Load("img/down1.png");
  SDL_Surface* CIMG_down2=IMG_Load("img/down2.png");
  SDL_Surface* CIMG_left1=IMG_Load("img/left1.png");
  SDL_Surface* CIMG_left2=IMG_Load("img/left2.png");
  SDL_Surface* CIMG_right1=IMG_Load("img/right1.png");
  SDL_Surface* CIMG_right2=IMG_Load("img/right2.png");

  SDL_Surface* CIMG_upleft1=IMG_Load("img/upleft1.png");
  SDL_Surface* CIMG_upleft2=IMG_Load("img/upleft2.png");
  SDL_Surface* CIMG_upright1=IMG_Load("img/upright1.png");
  SDL_Surface* CIMG_upright2=IMG_Load("img/upright2.png");
  SDL_Surface* CIMG_dwleft1=IMG_Load("img/dwleft1.png");
  SDL_Surface* CIMG_dwleft2=IMG_Load("img/dwleft2.png");
  SDL_Surface* CIMG_dwright1=IMG_Load("img/dwright1.png");
  SDL_Surface* CIMG_dwright2=IMG_Load("img/dwright2.png");

  SDL_Surface* CIMG_dtogi1=IMG_Load("img/dtogi1.png");
  SDL_Surface* CIMG_dtogi2=IMG_Load("img/dtogi2.png");
  SDL_Surface* CIMG_ltogi1=IMG_Load("img/ltogi1.png");
  SDL_Surface* CIMG_ltogi2=IMG_Load("img/ltogi2.png");
  SDL_Surface* CIMG_rtogi1=IMG_Load("img/rtogi1.png");
  SDL_Surface* CIMG_rtogi2=IMG_Load("img/rtogi2.png");
  SDL_Surface* CIMG_utogi1=IMG_Load("img/utogi1.png");
  SDL_Surface* CIMG_utogi2=IMG_Load("img/utogi2.png");

animation animationpattern[]={
    { CIMG_mati2,    CIMG_mati2 },	/* state == CHASER_STOP */
    { CIMG_jare2,    CIMG_mati2 },	/* state == CHASER_JARE */
    { CIMG_kaki1,    CIMG_kaki2 },	/* state == CHASER_KAKI */
    { CIMG_mati3,    CIMG_mati3 },	/* state == CHASER_AKUBI */
    { CIMG_sleep1,   CIMG_sleep2 },	/* state == CHASER_SLEEP */
    { CIMG_awake,    CIMG_awake },	/* state == CHASER_AWAKE */

    { CIMG_up1,      CIMG_up2 },	/* state == CHASER_U_MOVE */
    { CIMG_down1,    CIMG_down2 },	/* state == CHASER_D_MOVE */
    { CIMG_left1,    CIMG_left2 },	/* state == CHASER_L_MOVE */
    { CIMG_right1,   CIMG_right2 },	/* state == CHASER_R_MOVE */

    { CIMG_upleft1,  CIMG_upleft2 },	/* state == CHASER_UL_MOVE */
    { CIMG_upright1, CIMG_upright2 },	/* state == CHASER_UR_MOVE */
    { CIMG_dwleft1,  CIMG_dwleft2 },	/* state == CHASER_DL_MOVE */
    { CIMG_dwright1, CIMG_dwright2 },	/* state == CHASER_DR_MOVE */

    { CIMG_utogi1,   CIMG_utogi2 },	/* state == CHASER_U_TOGI */
    { CIMG_dtogi1,   CIMG_dtogi2 },	/* state == CHASER_D_TOGI */
    { CIMG_ltogi1,   CIMG_ltogi2 },	/* state == CHASER_L_TOGI */
    { CIMG_rtogi1,   CIMG_rtogi2 },	/* state == CHASER_R_TOGI */
  };

// ----------------------------------------------------------------
inline void update(){
  for (uint16_t d=0; d<NUMCHASER; d++) { chaserthink(&Chaser[d]); }
}

// ----------------------------------------------------------------
void setup() {
  for (uint16_t d=0; d<NUMCHASER; d++) {
    setupchaser(
		&Chaser[d],
		(boundingbox){.ul={.x=0,.y=0},.lr={.x=(SCREEN_WIDTH-BITMAP_WIDTH),.y=(SCREEN_HEIGHT-BITMAP_HEIGHT)}}
		);
  }

  // run the chasers through a few interation to put them in a "random" spots.
  for (uint16_t n=0; n<50; n++) { update(); }
}

// ----------------------------------------------------------------
#if SDL_MAJOR_VERSION == 2
SDL_Window* gWindow = NULL;
SDL_Surface* gScreenSurface = NULL;
#elif SDL_MAJOR_VERSION == 1 || defined(__EMSCRIPTEN__)
SDL_Surface* screen = NULL;
#endif

// ----------------------------------------------------------------
void loop(){
  // green background
#if SDL_MAJOR_VERSION == 2
  SDL_FillRect(gScreenSurface, NULL, SDL_MapRGB(gScreenSurface->format, 0,0x80, 0));
#elif SDL_MAJOR_VERSION == 1 || defined(__EMSCRIPTEN__)
  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0,0x80, 0));
#endif

  SDL_Rect dstrect={.x=0,.y=0,.w=32,.h=32};
  for (uint16_t d=0; d<NUMCHASER; d++) {
    chaser *c=&Chaser[d];
    SDL_Surface* cimg;

    if ( c->state != CHASER_SLEEP ) {
      cimg=((c->tickcount % 2 == 0 )?
	    animationpattern[c->state].tickeven :
	    animationpattern[c->state].tickodd );
    } else {
      cimg=((c->tickcount % 8 <= 3) ?
	    animationpattern[c->state].tickeven :
	    animationpattern[c->state].tickodd );
    }

    dstrect.x = c->x;
    dstrect.y = c->y;

#if SDL_MAJOR_VERSION == 2
    SDL_BlitSurface( cimg, NULL, gScreenSurface, &dstrect );
#elif SDL_MAJOR_VERSION == 1 || defined(__EMSCRIPTEN__)
    SDL_BlitSurface( cimg, NULL, screen, &dstrect );
#endif
  }

#if SDL_MAJOR_VERSION == 2
  SDL_UpdateWindowSurface( gWindow );
#elif SDL_MAJOR_VERSION == 1 || defined(__EMSCRIPTEN__)
  SDL_Flip(screen);
#endif

  update();
}

int main(int argc, char* args[]) {
  setup();

#if SDL_MAJOR_VERSION == 2
  SDL_Init(SDL_INIT_VIDEO);
  gWindow = SDL_CreateWindow( "Chaser", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN );
  gScreenSurface = SDL_GetWindowSurface( gWindow );
#elif SDL_MAJOR_VERSION == 1 || defined(__EMSCRIPTEN__)
  SDL_Init( SDL_INIT_VIDEO );
  screen = SDL_SetVideoMode( SCREEN_WIDTH, SCREEN_HEIGHT, 32, SDL_SWSURFACE );
#endif

#if defined(__EMSCRIPTEN__)
  emscripten_set_main_loop(loop, 10, 0);
#else
  SDL_Event e;

  // ----------------------------------------------------------------
  bool quit=false;
  while( !quit ) {
    if ( SDL_PollEvent( &e ) != 0 ) {
      switch (e.type) {
      case  SDL_QUIT:
	quit = true;
	break;
      case SDL_KEYDOWN:
	switch (e.key.keysym.sym) {
	case SDLK_ESCAPE:
	case SDLK_q:
	  quit = true;
	  break;
	}
	break;
      }
    }
    loop();

    SDL_Delay(100);
  }
    // ----------------------------------------------------------------
#if SDL_MAJOR_VERSION == 2
  SDL_DestroyWindow( gWindow );
#endif
  SDL_Quit();

  return 0;
#endif
}

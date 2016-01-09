-- -*- mode:lua; indent-tabs-mode:nil; -*-
require('os')
require('luarocks.loader')

local ffi = require('ffi')
local chaser_so =  ffi.load('./_chaser.so')

local SDL2 = require('SDL')
local SDL2_image = require('SDL.image')

----------------------------------------------------------------
-- chaser.h typedefs
ffi.cdef[[
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

void setupchaser(chaser *c, boundingbox box);
void chaserthink(chaser *c);
]]

----------------------------------------------------------------
local consts = {
   ----------------
   -- states
   CHASER_STOP=0,
   CHASER_JARE=1,
   CHASER_KAKI=2,
   CHASER_AKUBI=3,
   CHASER_SLEEP=4,
   CHASER_AWAKE=5,
   CHASER_U_MOVE=6,
   CHASER_D_MOVE=7,
   CHASER_L_MOVE=8,
   CHASER_R_MOVE=9,
   CHASER_UL_MOVE=10,
   CHASER_UR_MOVE=11,
   CHASER_DL_MOVE=12,
   CHASER_DR_MOVE=13,
   CHASER_U_TOGI=14,
   CHASER_D_TOGI=15,
   CHASER_L_TOGI=16,
   CHASER_R_TOGI=17,

   CHASER_STOP_TIME=4,
   CHASER_JARE_TIME=10,
   CHASER_KAKI_TIME=4,
   CHASER_AKUBI_TIME=3,
   CHASER_AWAKE_TIME=3,
   CHASER_TOGI_TIME=10,
   ----------------
   NORMAL_STATE=1
}
setmetatable(_G, {__newindex=function(t, k, v)
		     assert(not consts[k], 'const variable!')
		     rawset(t, k, v)
		 end}
)

local BITMAP_WIDTH=32
local BITMAP_HEIGHT=32
local SCREEN_HEIGHT=320
local SCREEN_WIDTH=640
----------------------------------------------------------------
local fps=5
local NUMCHASER=8
local Chaser={}

----------------------------------------------------------------
CIMG_jare2=SDL2_image.load("img/jare2.png")
CIMG_mati2=SDL2_image.load("img/mati2.png")
CIMG_kaki1=SDL2_image.load("img/kaki1.png")
CIMG_kaki2=SDL2_image.load("img/kaki2.png")
CIMG_mati3=SDL2_image.load("img/mati3.png")
CIMG_sleep1=SDL2_image.load("img/sleep1.png")
CIMG_sleep2=SDL2_image.load("img/sleep2.png")
CIMG_awake=SDL2_image.load("img/awake.png")

CIMG_up1=SDL2_image.load("img/up1.png")
CIMG_up2=SDL2_image.load("img/up2.png")
CIMG_down1=SDL2_image.load("img/down1.png")
CIMG_down2=SDL2_image.load("img/down2.png")
CIMG_left1=SDL2_image.load("img/left1.png")
CIMG_left2=SDL2_image.load("img/left2.png")
CIMG_right1=SDL2_image.load("img/right1.png")
CIMG_right2=SDL2_image.load("img/right2.png")

CIMG_upleft1=SDL2_image.load("img/upleft1.png")
CIMG_upleft2=SDL2_image.load("img/upleft2.png")
CIMG_upright1=SDL2_image.load("img/upright1.png")
CIMG_upright2=SDL2_image.load("img/upright2.png")
CIMG_dwleft1=SDL2_image.load("img/dwleft1.png")
CIMG_dwleft2=SDL2_image.load("img/dwleft2.png")
CIMG_dwright1=SDL2_image.load("img/dwright1.png")
CIMG_dwright2=SDL2_image.load("img/dwright2.png")

CIMG_dtogi1=SDL2_image.load("img/dtogi1.png")
CIMG_dtogi2=SDL2_image.load("img/dtogi2.png")
CIMG_ltogi1=SDL2_image.load("img/ltogi1.png")
CIMG_ltogi2=SDL2_image.load("img/ltogi2.png")
CIMG_rtogi1=SDL2_image.load("img/rtogi1.png")
CIMG_rtogi2=SDL2_image.load("img/rtogi2.png")
CIMG_utogi1=SDL2_image.load("img/utogi1.png")
CIMG_utogi2=SDL2_image.load("img/utogi2.png")

animationpattern={
   { tickodd=CIMG_mati2,    tickeven=CIMG_mati2 },	-- state == CHASER_STOP
   { tickodd=CIMG_jare2,    tickeven=CIMG_mati2 },	-- state == CHASER_JARE
   { tickodd=CIMG_kaki1,    tickeven=CIMG_kaki2 },	-- state == CHASER_KAKI
   { tickodd=CIMG_mati3,    tickeven=CIMG_mati3 },	-- state == CHASER_AKUBI
   { tickodd=CIMG_sleep1,   tickeven=CIMG_sleep2 },	-- state == CHASER_SLEEP
   { tickodd=CIMG_awake,    tickeven=CIMG_awake },	-- state == CHASER_AWAKE

   { tickodd=CIMG_up1,      tickeven=CIMG_up2 },	-- state == CHASER_U_MOVE
   { tickodd=CIMG_down1,    tickeven=CIMG_down2 },	-- state == CHASER_D_MOVE
   { tickodd=CIMG_left1,    tickeven=CIMG_left2 },	-- state == CHASER_L_MOVE
   { tickodd=CIMG_right1,   tickeven=CIMG_right2 },	-- state == CHASER_R_MOVE
   
   { tickodd=CIMG_upleft1,  tickeven=CIMG_upleft2 },	-- state == CHASER_UL_MOVE
   { tickodd=CIMG_upright1, tickeven=CIMG_upright2 },	-- state == CHASER_UR_MOVE
   { tickodd=CIMG_dwleft1,  tickeven=CIMG_dwleft2 },	-- state == CHASER_DL_MOVE
   { tickodd=CIMG_dwright1, tickeven=CIMG_dwright2 },	-- state == CHASER_DR_MOVE

   { tickodd=CIMG_utogi1,   tickeven=CIMG_utogi2 },	-- state == CHASER_U_TOGI
   { tickodd=CIMG_dtogi1,   tickeven=CIMG_dtogi2 },	-- state == CHASER_D_TOGI
   { tickodd=CIMG_ltogi1,   tickeven=CIMG_ltogi2 },	-- state == CHASER_L_TOGI
   { tickodd=CIMG_rtogi1,   tickeven=CIMG_rtogi2 },	-- state == CHASER_R_TOGI
}

----------------------------------------------------------------
local function update()
   for i,c in ipairs(Chaser) do
      chaser_so.chaserthink(c)
   end
end

local function setup()
   local screenbb=ffi.new('boundingbox',
                          ffi.new('xycoord',0, 0),
                          ffi.new('xycoord',(SCREEN_WIDTH-BITMAP_WIDTH),(SCREEN_HEIGHT-BITMAP_HEIGHT))
   )

   for n=1,NUMCHASER do
      Chaser[n]=ffi.new("chaser")
      chaser_so.setupchaser(Chaser[n], screenbb)
   end

   -- run the chasers through a few interation to put them in a "random" spots.
   for n=1,50 do
      update()
   end
end

----------------------------------------------------------------
-- MAIN
local ret,err= SDL2.init( SDL2.flags.Video );
if not ret then
   error(err)
end

local gWindow, err = SDL2.createWindow({
   title="Chaser",
   width=SCREEN_WIDTH,
   height=SCREEN_HEIGHT
})
if not gWindow then
   error(err)
end

local gRenderer,err=SDL2.createRenderer(gWindow,-1)
if not gRenderer then
   error(err)
end

local ret,err=gRenderer:setDrawColor({r=0x00, g=0x80, b=0x00})
----------------
setup()
         
local quit=false;
while(not(quit)) do
   start = SDL2.getTicks()
   
   for e in SDL2.pollEvent() do
      if (e.type == SDL2.event.Quit) then
         quit = true;
         break
      elseif (e.type == SDL2.event.KeyDown) then
         if ((e.keysym.sym==SDL2.key.Escape) or (e.keysym.sym==SDL2.key.q)) then
            quit = true;
            break;
         end
      end
   end

   gRenderer:clear()
   for i,c in ipairs(Chaser) do
      local cimg
      local cstate=c.state+1 -- LUA indexes start at one. so offset animation reference
      if ( not(c.state == consts.CHASER_SLEEP) ) then
         cimg=(((c.tickcount % 2) == 0 ) and
               animationpattern[cstate].tickeven or
               animationpattern[cstate].tickodd )
      else
         cimg=(((c.tickcount % 8) <= 3) and
               animationpattern[cstate].tickeven or
               animationpattern[cstate].tickodd )
      end

      local cimg_t, err = gRenderer:createTextureFromSurface(cimg)
      gRenderer:copy( cimg_t, nil, {x=c.x,y=c.y, w=BITMAP_WIDTH,h=BITMAP_HEIGHT})
  end

   gRenderer:present()

   update();

   if (1000/fps > SDL2.getTicks()-start) then
      SDL2.delay(1000/fps-(SDL2.getTicks()-start))
   end
end

SDL2.quit()

# -*- mode:python; indent-tabs-mode:nil; -*-
import sys
import time

import Image
import ImageDraw

import Adafruit_SSD1306

from chaser import *

BITMAP_WIDTH=32
BITMAP_HEIGHT=32

################################################################
NUMCHASER=3
Chaser=[]

################################################################
class bitmapmask:
    def __init__(self, btm, msk):
        self.btm=btm
        self.msk=msk

class animation:
    def __init__(self, tickeven, tickodd):
        self.tickeven=tickeven
        self.tickodd=tickodd

################################################################
# Raspberry Pi pin configuration:
RST = 24

# 128x64 display with hardware I2C:
disp = Adafruit_SSD1306.SSD1306_128_64(rst=RST)

# Initialize library.
disp.begin()

# Get display width and height.
SCREEN_WIDTH=disp.width
SCREEN_HEIGHT=disp.height

# Clear display.
disp.clear()
disp.display()

image = Image.new('1', (SCREEN_WIDTH, SCREEN_HEIGHT))
draw = ImageDraw.Draw(image)

################################################################
CIMG_jare2=bitmapmask(Image.open("img/btm/jare2.png").convert('1'),Image.open("img/msk/jare2.png").convert('1'))
CIMG_mati2=bitmapmask(Image.open("img/btm/mati2.png").convert('1'),Image.open("img/msk/mati2.png").convert('1'))
CIMG_kaki1=bitmapmask(Image.open("img/btm/kaki1.png").convert('1'),Image.open("img/msk/kaki1.png").convert('1'))
CIMG_kaki2=bitmapmask(Image.open("img/btm/kaki2.png").convert('1'),Image.open("img/msk/kaki2.png").convert('1'))
CIMG_mati3=bitmapmask(Image.open("img/btm/mati3.png").convert('1'),Image.open("img/msk/mati3.png").convert('1'))
CIMG_sleep1=bitmapmask(Image.open("img/btm/sleep1.png").convert('1'),Image.open("img/msk/sleep1.png").convert('1'))
CIMG_sleep2=bitmapmask(Image.open("img/btm/sleep2.png").convert('1'),Image.open("img/msk/sleep2.png").convert('1'))
CIMG_awake=bitmapmask(Image.open("img/btm/awake.png").convert('1'),Image.open("img/msk/awake.png").convert('1'))

CIMG_up1=bitmapmask(Image.open("img/btm/up1.png").convert('1'),Image.open("img/msk/up1.png").convert('1'))
CIMG_up2=bitmapmask(Image.open("img/btm/up2.png").convert('1'),Image.open("img/msk/up2.png").convert('1'))
CIMG_down1=bitmapmask(Image.open("img/btm/down1.png").convert('1'),Image.open("img/msk/down1.png").convert('1'))
CIMG_down2=bitmapmask(Image.open("img/btm/down2.png").convert('1'),Image.open("img/msk/down2.png").convert('1'))
CIMG_left1=bitmapmask(Image.open("img/btm/left1.png").convert('1'),Image.open("img/msk/left1.png").convert('1'))
CIMG_left2=bitmapmask(Image.open("img/btm/left2.png").convert('1'),Image.open("img/msk/left2.png").convert('1'))
CIMG_right1=bitmapmask(Image.open("img/btm/right1.png").convert('1'),Image.open("img/msk/right1.png").convert('1'))
CIMG_right2=bitmapmask(Image.open("img/btm/right2.png").convert('1'),Image.open("img/msk/right2.png").convert('1'))

CIMG_upleft1=bitmapmask(Image.open("img/btm/upleft1.png").convert('1'),Image.open("img/msk/upleft1.png").convert('1'))
CIMG_upleft2=bitmapmask(Image.open("img/btm/upleft2.png").convert('1'),Image.open("img/msk/upleft2.png").convert('1'))
CIMG_upright1=bitmapmask(Image.open("img/btm/upright1.png").convert('1'),Image.open("img/msk/upright1.png").convert('1'))
CIMG_upright2=bitmapmask(Image.open("img/btm/upright2.png").convert('1'),Image.open("img/msk/upright2.png").convert('1'))
CIMG_dwleft1=bitmapmask(Image.open("img/btm/dwleft1.png").convert('1'),Image.open("img/msk/dwleft1.png").convert('1'))
CIMG_dwleft2=bitmapmask(Image.open("img/btm/dwleft2.png").convert('1'),Image.open("img/msk/dwleft2.png").convert('1'))
CIMG_dwright1=bitmapmask(Image.open("img/btm/dwright1.png").convert('1'),Image.open("img/msk/dwright1.png").convert('1'))
CIMG_dwright2=bitmapmask(Image.open("img/btm/dwright2.png").convert('1'),Image.open("img/msk/dwright2.png").convert('1'))

CIMG_dtogi1=bitmapmask(Image.open("img/btm/dtogi1.png").convert('1'),Image.open("img/msk/dtogi1.png").convert('1'))
CIMG_dtogi2=bitmapmask(Image.open("img/btm/dtogi2.png").convert('1'),Image.open("img/msk/dtogi2.png").convert('1'))
CIMG_ltogi1=bitmapmask(Image.open("img/btm/ltogi1.png").convert('1'),Image.open("img/msk/ltogi1.png").convert('1'))
CIMG_ltogi2=bitmapmask(Image.open("img/btm/ltogi2.png").convert('1'),Image.open("img/msk/ltogi2.png").convert('1'))
CIMG_rtogi1=bitmapmask(Image.open("img/btm/rtogi1.png").convert('1'),Image.open("img/msk/rtogi1.png").convert('1'))
CIMG_rtogi2=bitmapmask(Image.open("img/btm/rtogi2.png").convert('1'),Image.open("img/msk/rtogi2.png").convert('1'))
CIMG_utogi1=bitmapmask(Image.open("img/btm/utogi1.png").convert('1'),Image.open("img/msk/utogi1.png").convert('1'))
CIMG_utogi2=bitmapmask(Image.open("img/btm/utogi2.png").convert('1'),Image.open("img/msk/utogi2.png").convert('1'))

animationpattern=[
    animation(CIMG_mati2,    CIMG_mati2 ),	# state == CHASER_STOP

    animation(CIMG_jare2,    CIMG_mati2 ),	# state == CHASER_JARE
    animation(CIMG_kaki1,    CIMG_kaki2 ),	# state == CHASER_KAKI
    animation(CIMG_mati3,    CIMG_mati3 ),	# state == CHASER_AKUBI
    animation(CIMG_sleep1,   CIMG_sleep2 ),	# state == CHASER_SLEEP
    animation(CIMG_awake,    CIMG_awake ),	# state == CHASER_AWAKE

    animation(CIMG_up1,      CIMG_up2 ),	# state == CHASER_U_MOVE
    animation(CIMG_down1,    CIMG_down2 ),	# state == CHASER_D_MOVE
    animation(CIMG_left1,    CIMG_left2 ),	# state == CHASER_L_MOVE
    animation(CIMG_right1,   CIMG_right2 ),	# state == CHASER_R_MOVE
    
    animation(CIMG_upleft1,  CIMG_upleft2 ),	# state == CHASER_UL_MOVE
    animation(CIMG_upright1, CIMG_upright2 ),	# state == CHASER_UR_MOVE
    animation(CIMG_dwleft1,  CIMG_dwleft2 ),	# state == CHASER_DL_MOVE
    animation(CIMG_dwright1, CIMG_dwright2 ),	# state == CHASER_DR_MOVE

    animation(CIMG_utogi1,   CIMG_utogi2 ),	# state == CHASER_U_TOGI
    animation(CIMG_dtogi1,   CIMG_dtogi2 ),	# state == CHASER_D_TOGI
    animation(CIMG_ltogi1,   CIMG_ltogi2 ),	# state == CHASER_L_TOGI
    animation(CIMG_rtogi1,   CIMG_rtogi2 )	# state == CHASER_R_TOGI
]

################################################################
def update():
    for c in Chaser:
        c.chaserthink()

def setup():
    screenbb=boundingbox(xycoord(0,0),xycoord((SCREEN_WIDTH-BITMAP_WIDTH),(SCREEN_HEIGHT-BITMAP_HEIGHT)))
    #
    for n in range(1,NUMCHASER+1):
        c=chaser(screenbb)
        Chaser.append(c)
    #
    # run the chasers through a few interation to put them in a "random" spots.
    for n in range(0,50):
        update()

def loop():
    while True:
        update()
	# Clear background
	draw.rectangle((0,0,SCREEN_WIDTH,SCREEN_HEIGHT), outline=0, fill=1)
        #
        for c in Chaser:
            cimg=None;
            if (c.state != chaser.CHASER_SLEEP):
                if ((c.tickcount % 2) == 0):
                  cimg=animationpattern[c.state].tickeven
                else:
                  cimg=animationpattern[c.state].tickodd
            else:
                if ((c.tickcount % 8) <= 3):
                  cimg=animationpattern[c.state].tickeven
                else:
                  cimg=animationpattern[c.state].tickodd
            draw.bitmap((c.x, c.y), cimg.msk, fill=1)
            draw.bitmap((c.x, c.y), cimg.btm)
            #
        disp.image(image)
	disp.display()
        #
        time.sleep(0.1)

def main():
    setup()
    loop()

if __name__ == "__main__":
    exitcode = main()
    sys.exit(exitcode)

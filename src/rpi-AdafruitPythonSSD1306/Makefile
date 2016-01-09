#
#
#
CC=gcc
CPP=g++

dCHASER=../../images/bitmaps/_base/neko

IMAGES=\
	img/btm/awake.png \
	img/btm/down1.png \
	img/btm/down2.png \
	img/btm/dtogi1.png \
	img/btm/dtogi2.png \
	img/btm/dwleft1.png \
	img/btm/dwleft2.png \
	img/btm/dwright1.png \
	img/btm/dwright2.png \
	img/btm/jare2.png \
	img/btm/kaki1.png \
	img/btm/kaki2.png \
	img/btm/left1.png \
	img/btm/left2.png \
	img/btm/ltogi1.png \
	img/btm/ltogi2.png \
	img/btm/mati2.png \
	img/btm/mati3.png \
	img/btm/right1.png \
	img/btm/right2.png \
	img/btm/rtogi1.png \
	img/btm/rtogi2.png \
	img/btm/sleep1.png \
	img/btm/sleep2.png \
	img/btm/up1.png \
	img/btm/up2.png \
	img/btm/upleft1.png \
	img/btm/upleft2.png \
	img/btm/upright1.png \
	img/btm/upright2.png \
	img/btm/utogi1.png \
	img/btm/utogi2.png \
\
	img/msk/awake.png \
	img/msk/down1.png \
	img/msk/down2.png \
	img/msk/dtogi1.png \
	img/msk/dtogi2.png \
	img/msk/dwleft1.png \
	img/msk/dwleft2.png \
	img/msk/dwright1.png \
	img/msk/dwright2.png \
	img/msk/jare2.png \
	img/msk/kaki1.png \
	img/msk/kaki2.png \
	img/msk/left1.png \
	img/msk/left2.png \
	img/msk/ltogi1.png \
	img/msk/ltogi2.png \
	img/msk/mati2.png \
	img/msk/mati3.png \
	img/msk/right1.png \
	img/msk/right2.png \
	img/msk/rtogi1.png \
	img/msk/rtogi2.png \
	img/msk/sleep1.png \
	img/msk/sleep2.png \
	img/msk/up1.png \
	img/msk/up2.png \
	img/msk/upleft1.png \
	img/msk/upleft2.png \
	img/msk/upright1.png \
	img/msk/upright2.png \
	img/msk/utogi1.png \
	img/msk/utogi2.png

#----------------
all: _chaser.so $(IMAGES)

clean:
	-rm -f *~ _chaser.so chaser.pyc
	-rm -rf img

#----------------
_chaser.so: ../chaser.c ../chaser.h
	$(CC) -I../ -shared -Wl,-soname,chaser -o $@ -fPIC ../chaser.c

#----------------
img/btm/.mkdir:
	-mkdir -p img/btm
	date > $@

img/msk/.mkdir:
	-mkdir -p img/msk
	date > $@

$(IMAGES): img/msk/.mkdir img/btm/.mkdir

img/msk/%: $(dCHASER)/%
	convert $< -alpha extract  $@

img/btm/%: $(dCHASER)/%
	convert $< -alpha remove -negate $@

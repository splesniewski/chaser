#
#
#
CC=gcc

dCHASER=../../images/bitmaps/_base/neko
#dCHASER=../../images/bitmaps/kreativekorp/CLORPOIN
#dCHASER=../../images/bitmaps/kreativekorp/Calico_Tabby

IMAGES=\
	img/awake.png \
	img/down1.png \
	img/down2.png \
	img/dtogi1.png \
	img/dtogi2.png \
	img/dwleft1.png \
	img/dwleft2.png \
	img/dwright1.png \
	img/dwright2.png \
	img/jare2.png \
	img/kaki1.png \
	img/kaki2.png \
	img/left1.png \
	img/left2.png \
	img/ltogi1.png \
	img/ltogi2.png \
	img/mati2.png \
	img/mati3.png \
	img/right1.png \
	img/right2.png \
	img/rtogi1.png \
	img/rtogi2.png \
	img/sleep1.png \
	img/sleep2.png \
	img/up1.png \
	img/up2.png \
	img/upleft1.png \
	img/upleft2.png \
	img/upright1.png \
	img/upright2.png \
	img/utogi1.png \
	img/utogi2.png

#----------------
all: _chaser.so $(IMAGES)

clean:
	-rm -f *~ _chaser.so
	-rm -rf img

#----------------
_chaser.so: ../chaser.c ../chaser.h
	$(CC) -I../ -shared -o $@ -fPIC ../chaser.c
#	$(CC) -I../ -shared -Wl,-soname,chaser -o $@ -fPIC ../chaser.c

#----------------
img/.mkdir:
	-mkdir img
	date > $@

$(IMAGES): img/.mkdir

img/%: $(dCHASER)/%
	cp $< $@

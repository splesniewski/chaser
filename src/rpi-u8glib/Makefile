#
#
#
dCHASER=../../images/bitmaps/_base/neko

cPYTHON2=/usr/bin/python2.7
cIM2ARDUINO=$(cPYTHON2) ../../bin/im2arduino.py
CPLUSPLUS=g++
CC=gcc

U8GLIBDIR=/home/spl/_

IMAGES=\
	img/awake.c \
	img/down1.c \
	img/down2.c \
	img/dtogi1.c \
	img/dtogi2.c \
	img/dwleft1.c \
	img/dwleft2.c \
	img/dwright1.c \
	img/dwright2.c \
	img/jare2.c \
	img/kaki1.c \
	img/kaki2.c \
	img/left1.c \
	img/left2.c \
	img/ltogi1.c \
	img/ltogi2.c \
	img/mati2.c \
	img/mati3.c \
	img/right1.c \
	img/right2.c \
	img/rtogi1.c \
	img/rtogi2.c \
	img/sleep1.c \
	img/sleep2.c \
	img/up1.c \
	img/up2.c \
	img/upleft1.c \
	img/upleft2.c \
	img/upright1.c \
	img/upright2.c \
	img/utogi1.c \
	img/utogi2.c

#----------------
all: rpi-u8glib-ssd1306 rpi-u8glib-sdl

clean:
	-rm -f *~
	-rm -f images_all.h binary.h
	-rm -rf img
	-rm chaser.o rpi-u8glib-ssd1306 rpi-u8glib-sdl

veryclean: clean
	-rm -rf u8glib

#----------------
binary.h:
	perl -e 'foreach my $$n (0..255){ printf("#define B%08b %i\n",$$n,$$n);}' > $@

chaser.o: ../chaser.c ../chaser.h
	$(CC) \
		-I../ \
		-c ../chaser.c

rpi-u8glib-ssd1306: rpi-u8glib.c rpi-u8glib.h chaser.o images_all.h binary.h
	$(CPLUSPLUS) \
		-I../ -I$(U8GLIBDIR)/include/ \
		-DU8G_16BIT -DU8G_RASPBERRY_PI -DU8G_WITH_PINLIST \
		-L$(U8GLIBDIR)/lib/ -Wl,-rpath -Wl,$(U8GLIBDIR)/lib/ \
		chaser.o \
		-o $@ rpi-u8glib.c \
		-lu8gwpi -lwiringPi 

rpi-u8glib-sdl: rpi-u8glib.c rpi-u8glib.h chaser.o images_all.h binary.h
	$(CPLUSPLUS) \
		-D CHASER_U8G_SDL \
		-I../ -I$(U8GLIBDIR)/include/ \
		-DU8G_16BIT \
		-L$(U8GLIBDIR)/lib/ -Wl,-rpath -Wl,$(U8GLIBDIR)/lib/ \
		`sdl-config --cflags` \
		chaser.o \
		-o $@ rpi-u8glib.c \
		-lu8gsdl \
		`sdl-config --libs`

#----------------
images_all.h: $(IMAGES)
	cat $(IMAGES) > $@

img/.mkdir:
	-mkdir img
	date > $@

$(IMAGES): img/.mkdir

img/awake.c: $(dCHASER)/awake.png
	$(cIM2ARDUINO) --name awake $< > $@

img/down1.c: $(dCHASER)/down1.png
	$(cIM2ARDUINO) --name down1 $< > $@

img/down2.c: $(dCHASER)/down2.png
	$(cIM2ARDUINO) --name down2 $< > $@

img/dtogi1.c: $(dCHASER)/dtogi1.png
	$(cIM2ARDUINO) --name dtogi1 $< > $@

img/dtogi2.c: $(dCHASER)/dtogi2.png
	$(cIM2ARDUINO) --name dtogi2 $< > $@

img/dwleft1.c: $(dCHASER)/dwleft1.png
	$(cIM2ARDUINO) --name dwleft1 $< > $@

img/dwleft2.c: $(dCHASER)/dwleft2.png
	$(cIM2ARDUINO) --name dwleft2 $< > $@

img/dwright1.c: $(dCHASER)/dwright1.png
	$(cIM2ARDUINO) --name dwright1 $< > $@

img/dwright2.c: $(dCHASER)/dwright2.png
	$(cIM2ARDUINO) --name dwright2 $< > $@

img/jare2.c: $(dCHASER)/jare2.png
	$(cIM2ARDUINO) --name jare2 $< > $@

img/kaki1.c: $(dCHASER)/kaki1.png
	$(cIM2ARDUINO) --name kaki1 $< > $@

img/kaki2.c: $(dCHASER)/kaki2.png
	$(cIM2ARDUINO) --name kaki2 $< > $@

img/left1.c: $(dCHASER)/left1.png
	$(cIM2ARDUINO) --name left1 $< > $@

img/left2.c: $(dCHASER)/left2.png
	$(cIM2ARDUINO) --name left2 $< > $@

img/ltogi1.c: $(dCHASER)/ltogi1.png
	$(cIM2ARDUINO) --name ltogi1 $< > $@

img/ltogi2.c: $(dCHASER)/ltogi2.png
	$(cIM2ARDUINO) --name ltogi2 $< > $@

img/mati2.c: $(dCHASER)/mati2.png
	$(cIM2ARDUINO) --name mati2 $< > $@

img/mati3.c: $(dCHASER)/mati3.png
	$(cIM2ARDUINO) --name mati3 $< > $@

img/right1.c: $(dCHASER)/right1.png
	$(cIM2ARDUINO) --name right1 $< > $@

img/right2.c: $(dCHASER)/right2.png
	$(cIM2ARDUINO) --name right2 $< > $@

img/rtogi1.c: $(dCHASER)/rtogi1.png
	$(cIM2ARDUINO) --name rtogi1 $< > $@

img/rtogi2.c: $(dCHASER)/rtogi2.png
	$(cIM2ARDUINO) --name rtogi2 $< > $@

img/sleep1.c: $(dCHASER)/sleep1.png
	$(cIM2ARDUINO) --name sleep1 $< > $@

img/sleep2.c: $(dCHASER)/sleep2.png
	$(cIM2ARDUINO) --name sleep2 $< > $@

img/up1.c: $(dCHASER)/up1.png
	$(cIM2ARDUINO) --name up1 $< > $@

img/up2.c: $(dCHASER)/up2.png
	$(cIM2ARDUINO) --name up2 $< > $@

img/upleft1.c: $(dCHASER)/upleft1.png
	$(cIM2ARDUINO) --name upleft1 $< > $@

img/upleft2.c: $(dCHASER)/upleft2.png
	$(cIM2ARDUINO) --name upleft2 $< > $@

img/upright1.c: $(dCHASER)/upright1.png
	$(cIM2ARDUINO) --name upright1 $< > $@

img/upright2.c: $(dCHASER)/upright2.png
	$(cIM2ARDUINO) --name upright2 $< > $@

img/utogi1.c: $(dCHASER)/utogi1.png
	$(cIM2ARDUINO) --name utogi1 $< > $@

img/utogi2.c: $(dCHASER)/utogi2.png
	$(cIM2ARDUINO) --name utogi2 $< > $@

#----------------
make_u8glib:
	mkdir u8glib
	cd u8glib; \
		git clone https://github.com/olikraus/u8glib.git; \
		cd u8glib; \
		./autogen.sh ;\
		./configure --prefix=$(U8GLIBDIR) ;\
		time make install-libLTLIBRARIES install-includeHEADERS

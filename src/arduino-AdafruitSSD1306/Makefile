#
#
#
#dCHASER=../../images/bitmaps/_base/neko

cPYTHON2=python2.7
cIM2ARDUINO=$(cPYTHON2) ../../bin/im2arduino.py

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

all: images_all.h

clean:
	rm -f *~
	-rm -f images_all.h
	-rm -rf img

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


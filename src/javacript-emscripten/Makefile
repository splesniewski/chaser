#
#
#
HTMLDIR=html

dCHASER=../../images/bitmaps/_base/neko
#dCHASER=../../images/bitmaps/kreativekorp/CLORPOIN
#dCHASER=../../images/bitmaps/kreativekorp/Calico_Tabby

SHELL=bash

IMAGES=\
	$(HTMLDIR)/img/awake.png \
	$(HTMLDIR)/img/down1.png \
	$(HTMLDIR)/img/down2.png \
	$(HTMLDIR)/img/dtogi1.png \
	$(HTMLDIR)/img/dtogi2.png \
	$(HTMLDIR)/img/dwleft1.png \
	$(HTMLDIR)/img/dwleft2.png \
	$(HTMLDIR)/img/dwright1.png \
	$(HTMLDIR)/img/dwright2.png \
	$(HTMLDIR)/img/jare2.png \
	$(HTMLDIR)/img/kaki1.png \
	$(HTMLDIR)/img/kaki2.png \
	$(HTMLDIR)/img/left1.png \
	$(HTMLDIR)/img/left2.png \
	$(HTMLDIR)/img/ltogi1.png \
	$(HTMLDIR)/img/ltogi2.png \
	$(HTMLDIR)/img/mati2.png \
	$(HTMLDIR)/img/mati3.png \
	$(HTMLDIR)/img/right1.png \
	$(HTMLDIR)/img/right2.png \
	$(HTMLDIR)/img/rtogi1.png \
	$(HTMLDIR)/img/rtogi2.png \
	$(HTMLDIR)/img/sleep1.png \
	$(HTMLDIR)/img/sleep2.png \
	$(HTMLDIR)/img/up1.png \
	$(HTMLDIR)/img/up2.png \
	$(HTMLDIR)/img/upleft1.png \
	$(HTMLDIR)/img/upleft2.png \
	$(HTMLDIR)/img/upright1.png \
	$(HTMLDIR)/img/upright2.png \
	$(HTMLDIR)/img/utogi1.png \
	$(HTMLDIR)/img/utogi2.png

################################################################
all: $(IMAGES) $(HTMLDIR)/ChaserObj.js

clean:
	-rm -f *~
	-rm -f chaser.bc ChaserObj.bc ChaserObj.js
	-rm -f $(HTMLDIR)/ChaserObj.js $(HTMLDIR)/ChaserObj.js.mem
	-rm -rf $(HTMLDIR)/img 

################################################################
$(HTMLDIR)/img/.mkdir:
	-mkdir -p $(HTMLDIR)/img
	date > $@

$(IMAGES): $(HTMLDIR)/img/.mkdir

$(HTMLDIR)/img/%: $(dCHASER)/%
	cp $< $@

################################################################
emCC=emcc
emCPP=em++

emCC_FLAGS=-O2 -I../
emCPP_FLAGS=-O2 -I../ -std=c++11

chaser.bc: ../chaser.c
	$(emCC) $(emCC_FLAGS) ../chaser.c -o chaser.bc

ChaserObj.bc: ChaserObj.cpp ChaserObj.h
	$(emCPP) $(emCPP_FLAGS) --bind -c ChaserObj.cpp -o $@

$(HTMLDIR)/ChaserObj.js: ChaserObj.bc chaser.bc $(IMAGES)
	$(emCC) $(emCC_FLAGS) --bind chaser.bc ChaserObj.bc -o $@

#
#
#
SHELL=bash
all: sdl1chase sdl2chase

emscripten: emscripten/sdlchase.html

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

clean:
	-rm -rf img
	-rm -f *~ sdl1chase sdl2chase chaser.o
	-rm -f *~ sdlchase.bc chaser.bc
	-rm -rf emscripten

################################################################
img/.mkdir:
	-mkdir img
	date > $@

$(IMAGES): img/.mkdir

img/%: $(dCHASER)/%
	cp $< $@
################################################################
CC=gcc
CPP=g++

chaser.o: ../chaser.c
	$(CC) -I../ -c ../chaser.c

SDL1_CCFLAGS=$(shell sdl-config --cflags) -Wno-switch -I ../
SDL1_LDFLAGS=$(shell sdl-config --libs) -lSDL_image
sdl1chase: sdlchase.cpp $(IMAGES) chaser.o
	$(CPP) $(SDL1_CCFLAGS)  chaser.o -o $@ sdlchase.cpp  $(SDL1_LDFLAGS)

SDL2_CCFLAGS=$(shell sdl2-config --cflags) -Wno-switch -I ../
SDL2_LDFLAGS=$(shell sdl2-config --libs) -lSDL2_image
sdl2chase: sdlchase.cpp $(IMAGES) chaser.o
	$(CPP) $(SDL2_CCFLAGS)  chaser.o -o $@ sdlchase.cpp  $(SDL2_LDFLAGS)

################################################################
emCC=emcc
emCPP=em++
emCC_FLAGS=-O1 --use-preload-plugins -s STB_IMAGE=1 -I../
emCPP_FLAGS=-O2 --use-preload-plugins -s STB_IMAGE=1 -I../

chaser.bc: ../chaser.c
	$(emCC) $(emCPP_FLAGS) ../chaser.c -o chaser.bc

sdlchase.bc : sdlchase.cpp
	$(emCPP) $(emCPP_FLAGS) -DSDL_MAJOR_VERSION=2 sdlchase.cpp -o sdlchase.bc

emscripten/sdlchase.html: sdlchase.bc chaser.bc $(IMAGES)
	mkdir -p emscripten;
	$(emCPP) $(emCC_FLAGS) chaser.bc sdlchase.bc -o emscripten/sdlchase.html $(addprefix --preload-file ,$(IMAGES))

#
#
#
dCHASER_BW=../../images/bitmaps/_base/neko
dCHASER_COLOR=$(dCHASER_BW)
#dCHASER_COLOR=../../images/bitmaps/kreativekorp/Calico_Tabby

IMAGES=\
	resources/menuicon.png \
\
	resources/bw/btm/awake.png \
	resources/bw/btm/down1.png \
	resources/bw/btm/down2.png \
	resources/bw/btm/dtogi1.png \
	resources/bw/btm/dtogi2.png \
	resources/bw/btm/dwleft1.png \
	resources/bw/btm/dwleft2.png \
	resources/bw/btm/dwright1.png \
	resources/bw/btm/dwright2.png \
	resources/bw/btm/jare2.png \
	resources/bw/btm/kaki1.png \
	resources/bw/btm/kaki2.png \
	resources/bw/btm/left1.png \
	resources/bw/btm/left2.png \
	resources/bw/btm/ltogi1.png \
	resources/bw/btm/ltogi2.png \
	resources/bw/btm/mati2.png \
	resources/bw/btm/mati3.png \
	resources/bw/btm/right1.png \
	resources/bw/btm/right2.png \
	resources/bw/btm/rtogi1.png \
	resources/bw/btm/rtogi2.png \
	resources/bw/btm/sleep1.png \
	resources/bw/btm/sleep2.png \
	resources/bw/btm/up1.png \
	resources/bw/btm/up2.png \
	resources/bw/btm/upleft1.png \
	resources/bw/btm/upleft2.png \
	resources/bw/btm/upright1.png \
	resources/bw/btm/upright2.png \
	resources/bw/btm/utogi1.png \
	resources/bw/btm/utogi2.png \
\
	resources/bw/msk/awake.png \
	resources/bw/msk/down1.png \
	resources/bw/msk/down2.png \
	resources/bw/msk/dtogi1.png \
	resources/bw/msk/dtogi2.png \
	resources/bw/msk/dwleft1.png \
	resources/bw/msk/dwleft2.png \
	resources/bw/msk/dwright1.png \
	resources/bw/msk/dwright2.png \
	resources/bw/msk/jare2.png \
	resources/bw/msk/kaki1.png \
	resources/bw/msk/kaki2.png \
	resources/bw/msk/left1.png \
	resources/bw/msk/left2.png \
	resources/bw/msk/ltogi1.png \
	resources/bw/msk/ltogi2.png \
	resources/bw/msk/mati2.png \
	resources/bw/msk/mati3.png \
	resources/bw/msk/right1.png \
	resources/bw/msk/right2.png \
	resources/bw/msk/rtogi1.png \
	resources/bw/msk/rtogi2.png \
	resources/bw/msk/sleep1.png \
	resources/bw/msk/sleep2.png \
	resources/bw/msk/up1.png \
	resources/bw/msk/up2.png \
	resources/bw/msk/upleft1.png \
	resources/bw/msk/upleft2.png \
	resources/bw/msk/upright1.png \
	resources/bw/msk/upright2.png \
	resources/bw/msk/utogi1.png \
	resources/bw/msk/utogi2.png \
\
	resources/color/btm/awake.png \
	resources/color/btm/down1.png \
	resources/color/btm/down2.png \
	resources/color/btm/dtogi1.png \
	resources/color/btm/dtogi2.png \
	resources/color/btm/dwleft1.png \
	resources/color/btm/dwleft2.png \
	resources/color/btm/dwright1.png \
	resources/color/btm/dwright2.png \
	resources/color/btm/jare2.png \
	resources/color/btm/kaki1.png \
	resources/color/btm/kaki2.png \
	resources/color/btm/left1.png \
	resources/color/btm/left2.png \
	resources/color/btm/ltogi1.png \
	resources/color/btm/ltogi2.png \
	resources/color/btm/mati2.png \
	resources/color/btm/mati3.png \
	resources/color/btm/right1.png \
	resources/color/btm/right2.png \
	resources/color/btm/rtogi1.png \
	resources/color/btm/rtogi2.png \
	resources/color/btm/sleep1.png \
	resources/color/btm/sleep2.png \
	resources/color/btm/up1.png \
	resources/color/btm/up2.png \
	resources/color/btm/upleft1.png \
	resources/color/btm/upleft2.png \
	resources/color/btm/upright1.png \
	resources/color/btm/upright2.png \
	resources/color/btm/utogi1.png \
	resources/color/btm/utogi2.png

all: build/pebble-chaser.pbw

clean:
	pebble clean
	-rm -f *~ src/*~ chaser.o
	-rm -rf resources/bw resources/color resources/menuicon.png

veryclean: clean
	-rm -f pebble_colors_64.gif

build/pebble-chaser.pbw: $(IMAGES) ../chaser.c ../chaser.h src/math.c src/pebble-chaser.c src/pebble-chaser.h resources/menuicon.png
	pebble build

#----------------
$(IMAGES): resources/bw/msk/.mkdir resources/bw/btm/.mkdir resources/color/btm/.mkdir 
resources/menuicon.png:
	convert $(dCHASER_BW)/awake.png -crop 24x28+5+2 $@

#----------------
resources/bw/btm/.mkdir:
	-mkdir -p resources/bw/btm
	date > $@

resources/bw/msk/.mkdir:
	-mkdir -p resources/bw/msk
	date > $@

resources/bw/msk/%: $(dCHASER_BW)/%
	convert $< -alpha extract -negate $@

resources/bw/btm/%: $(dCHASER_BW)/%
	convert $< -alpha remove $@

#----------------
resources/color/btm/.mkdir:
	-mkdir -p resources/color/btm
	date > $@

pebble_colors_64.gif:
	curl -O https://developer.getpebble.com/assets/other/pebble_colors_64.gif

resources/color/btm_broken/%: $(dCHASER_COLOR)/% pebble_colors_64.gif
	convert $< \
		-quantize transparent \
		-dither None \
		-remap pebble_colors_64.gif \
		-define png:compression-level=9 \
		-define png:compression-strategy=0 \
		png24:$@

resources/color/btm/%: $(dCHASER_COLOR)/%
	cp $< $@


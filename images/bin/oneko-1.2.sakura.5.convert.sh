#!/bin/bash
dSRC=src/oneko-1.2.sakura.5
dDEST=bitmaps/oneko

createMaskedPng	() {
    image=$1
    mask=$2
    outputimage=$3

    # for B/W images the background of the base image need to be
    # black.  Apply mask to base image to get it black before appling
    # mask as transparency layer.
    
    convert \
	\( ${image} -alpha off ${mask} -compose difference -composite \) \
	-alpha	off \
	\( -negate ${mask} \) \
	-compose CopyOpacity \
	-composite \
	PNG32:${outputimage}
}

#----------------------------------------------------------------
echo "---convert: ${dSRC}---"

#----------------------------------------------------------------
mkdir -p ${dDEST}

#----------------------------------------------------------------
echo _cursors
mkdir -p ${dDEST}/_cursors
createMaskedPng	${dSRC}/cursors/bone_cursor.xbm		${dSRC}/cursors/bone_cursor_mask.xbm	${dDEST}/_cursors/bone.png
createMaskedPng	${dSRC}/cursors/bsd_cursor.xbm		${dSRC}/cursors/bsd_cursor_mask.xbm	${dDEST}/_cursors/bsd.png
createMaskedPng	${dSRC}/cursors/card_cursor.xbm		${dSRC}/cursors/card_cursor_mask.xbm	${dDEST}/_cursors/card.png
createMaskedPng	${dSRC}/cursors/mouse_cursor.xbm	${dSRC}/cursors/mouse_cursor_mask.xbm	${dDEST}/_cursors/mouse.png
createMaskedPng	${dSRC}/cursors/petal_cursor.xbm	${dSRC}/cursors/petal_cursor_mask.xbm	${dDEST}/_cursors/petal.png

#----------------------------------------------------------------
echo bsd
mkdir -p ${dDEST}/bsd
cp ${dSRC}/bitmaps/bsd/COPYRIGHT ${dDEST}/bsd/
createMaskedPng	${dSRC}/bitmaps/bsd/awake_bsd.xbm	${dSRC}/bitmasks/bsd/awake_bsd_mask.xbm		${dDEST}/bsd/awake.png
createMaskedPng	${dSRC}/bitmaps/bsd/down1_bsd.xbm	${dSRC}/bitmasks/bsd/down1_bsd_mask.xbm		${dDEST}/bsd/down1.png
createMaskedPng	${dSRC}/bitmaps/bsd/down2_bsd.xbm	${dSRC}/bitmasks/bsd/down2_bsd_mask.xbm		${dDEST}/bsd/down2.png
createMaskedPng	${dSRC}/bitmaps/bsd/dtogi1_bsd.xbm	${dSRC}/bitmasks/bsd/dtogi1_bsd_mask.xbm	${dDEST}/bsd/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/bsd/dtogi2_bsd.xbm	${dSRC}/bitmasks/bsd/dtogi2_bsd_mask.xbm	${dDEST}/bsd/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/bsd/dwleft1_bsd.xbm	${dSRC}/bitmasks/bsd/dwleft1_bsd_mask.xbm	${dDEST}/bsd/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/bsd/dwleft2_bsd.xbm	${dSRC}/bitmasks/bsd/dwleft2_bsd_mask.xbm	${dDEST}/bsd/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/bsd/dwright1_bsd.xbm	${dSRC}/bitmasks/bsd/dwright1_bsd_mask.xbm	${dDEST}/bsd/dwright1.png
createMaskedPng	${dSRC}/bitmaps/bsd/dwright2_bsd.xbm	${dSRC}/bitmasks/bsd/dwright2_bsd_mask.xbm	${dDEST}/bsd/dwright2.png
createMaskedPng	${dSRC}/bitmaps/bsd/jare2_bsd.xbm	${dSRC}/bitmasks/bsd/jare2_bsd_mask.xbm		${dDEST}/bsd/jare2.png
createMaskedPng	${dSRC}/bitmaps/bsd/kaki1_bsd.xbm	${dSRC}/bitmasks/bsd/kaki1_bsd_mask.xbm		${dDEST}/bsd/kaki1.png
createMaskedPng	${dSRC}/bitmaps/bsd/kaki2_bsd.xbm	${dSRC}/bitmasks/bsd/kaki2_bsd_mask.xbm		${dDEST}/bsd/kaki2.png
createMaskedPng	${dSRC}/bitmaps/bsd/left1_bsd.xbm	${dSRC}/bitmasks/bsd/left1_bsd_mask.xbm		${dDEST}/bsd/left1.png
createMaskedPng	${dSRC}/bitmaps/bsd/left2_bsd.xbm	${dSRC}/bitmasks/bsd/left2_bsd_mask.xbm		${dDEST}/bsd/left2.png
createMaskedPng	${dSRC}/bitmaps/bsd/ltogi1_bsd.xbm	${dSRC}/bitmasks/bsd/ltogi1_bsd_mask.xbm	${dDEST}/bsd/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/bsd/ltogi2_bsd.xbm	${dSRC}/bitmasks/bsd/ltogi2_bsd_mask.xbm	${dDEST}/bsd/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/bsd/mati2_bsd.xbm	${dSRC}/bitmasks/bsd/mati2_bsd_mask.xbm		${dDEST}/bsd/mati2.png
createMaskedPng	${dSRC}/bitmaps/bsd/mati3_bsd.xbm	${dSRC}/bitmasks/bsd/mati3_bsd_mask.xbm		${dDEST}/bsd/mati3.png
createMaskedPng	${dSRC}/bitmaps/bsd/right1_bsd.xbm	${dSRC}/bitmasks/bsd/right1_bsd_mask.xbm	${dDEST}/bsd/right1.png
createMaskedPng	${dSRC}/bitmaps/bsd/right2_bsd.xbm	${dSRC}/bitmasks/bsd/right2_bsd_mask.xbm	${dDEST}/bsd/right2.png
createMaskedPng	${dSRC}/bitmaps/bsd/rtogi1_bsd.xbm	${dSRC}/bitmasks/bsd/rtogi1_bsd_mask.xbm	${dDEST}/bsd/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/bsd/rtogi2_bsd.xbm	${dSRC}/bitmasks/bsd/rtogi2_bsd_mask.xbm	${dDEST}/bsd/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/bsd/sleep1_bsd.xbm	${dSRC}/bitmasks/bsd/sleep1_bsd_mask.xbm	${dDEST}/bsd/sleep1.png
createMaskedPng	${dSRC}/bitmaps/bsd/sleep2_bsd.xbm	${dSRC}/bitmasks/bsd/sleep2_bsd_mask.xbm	${dDEST}/bsd/sleep2.png
createMaskedPng	${dSRC}/bitmaps/bsd/space_bsd.xbm	${dSRC}/bitmasks/bsd/space_bsd_mask.xbm		${dDEST}/bsd/space.png
createMaskedPng	${dSRC}/bitmaps/bsd/up1_bsd.xbm		${dSRC}/bitmasks/bsd/up1_bsd_mask.xbm		${dDEST}/bsd/up1.png
createMaskedPng	${dSRC}/bitmaps/bsd/up2_bsd.xbm		${dSRC}/bitmasks/bsd/up2_bsd_mask.xbm		${dDEST}/bsd/up2.png
createMaskedPng	${dSRC}/bitmaps/bsd/upleft1_bsd.xbm	${dSRC}/bitmasks/bsd/upleft1_bsd_mask.xbm	${dDEST}/bsd/upleft1.png
createMaskedPng	${dSRC}/bitmaps/bsd/upleft2_bsd.xbm	${dSRC}/bitmasks/bsd/upleft2_bsd_mask.xbm	${dDEST}/bsd/upleft2.png
createMaskedPng	${dSRC}/bitmaps/bsd/upright1_bsd.xbm	${dSRC}/bitmasks/bsd/upright1_bsd_mask.xbm	${dDEST}/bsd/upright1.png
createMaskedPng	${dSRC}/bitmaps/bsd/upright2_bsd.xbm	${dSRC}/bitmasks/bsd/upright2_bsd_mask.xbm	${dDEST}/bsd/upright2.png
createMaskedPng	${dSRC}/bitmaps/bsd/utogi1_bsd.xbm	${dSRC}/bitmasks/bsd/utogi1_bsd_mask.xbm	${dDEST}/bsd/utogi1.png
createMaskedPng	${dSRC}/bitmaps/bsd/utogi2_bsd.xbm	${dSRC}/bitmasks/bsd/utogi2_bsd_mask.xbm	${dDEST}/bsd/utogi2.png

#----------------------------------------------------------------
echo dog
mkdir -p ${dDEST}/dog
createMaskedPng	${dSRC}/bitmaps/dog/awake_dog.xbm	${dSRC}/bitmasks/dog/awake_dog_mask.xbm		${dDEST}/dog/awake.png
createMaskedPng	${dSRC}/bitmaps/dog/down1_dog.xbm	${dSRC}/bitmasks/dog/down1_dog_mask.xbm		${dDEST}/dog/down1.png
createMaskedPng	${dSRC}/bitmaps/dog/down2_dog.xbm	${dSRC}/bitmasks/dog/down2_dog_mask.xbm		${dDEST}/dog/down2.png
createMaskedPng	${dSRC}/bitmaps/dog/dtogi1_dog.xbm	${dSRC}/bitmasks/dog/dtogi1_dog_mask.xbm	${dDEST}/dog/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/dtogi2_dog.xbm	${dSRC}/bitmasks/dog/dtogi2_dog_mask.xbm	${dDEST}/dog/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/dog/dwleft1_dog.xbm	${dSRC}/bitmasks/dog/dwleft1_dog_mask.xbm	${dDEST}/dog/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/dog/dwleft2_dog.xbm	${dSRC}/bitmasks/dog/dwleft2_dog_mask.xbm	${dDEST}/dog/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/dog/dwright1_dog.xbm	${dSRC}/bitmasks/dog/dwright1_dog_mask.xbm	${dDEST}/dog/dwright1.png
createMaskedPng	${dSRC}/bitmaps/dog/dwright2_dog.xbm	${dSRC}/bitmasks/dog/dwright2_dog_mask.xbm	${dDEST}/dog/dwright2.png
createMaskedPng	${dSRC}/bitmaps/dog/jare2_dog.xbm	${dSRC}/bitmasks/dog/jare2_dog_mask.xbm		${dDEST}/dog/jare2.png
createMaskedPng	${dSRC}/bitmaps/dog/kaki1_dog.xbm	${dSRC}/bitmasks/dog/kaki1_dog_mask.xbm		${dDEST}/dog/kaki1.png
createMaskedPng	${dSRC}/bitmaps/dog/kaki2_dog.xbm	${dSRC}/bitmasks/dog/kaki2_dog_mask.xbm		${dDEST}/dog/kaki2.png
createMaskedPng	${dSRC}/bitmaps/dog/left1_dog.xbm	${dSRC}/bitmasks/dog/left1_dog_mask.xbm		${dDEST}/dog/left1.png
createMaskedPng	${dSRC}/bitmaps/dog/left2_dog.xbm	${dSRC}/bitmasks/dog/left2_dog_mask.xbm		${dDEST}/dog/left2.png
createMaskedPng	${dSRC}/bitmaps/dog/ltogi1_dog.xbm	${dSRC}/bitmasks/dog/ltogi1_dog_mask.xbm	${dDEST}/dog/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/ltogi2_dog.xbm	${dSRC}/bitmasks/dog/ltogi2_dog_mask.xbm	${dDEST}/dog/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/dog/mati2_dog.xbm	${dSRC}/bitmasks/dog/mati2_dog_mask.xbm		${dDEST}/dog/mati2.png
createMaskedPng	${dSRC}/bitmaps/dog/mati3_dog.xbm	${dSRC}/bitmasks/dog/mati3_dog_mask.xbm		${dDEST}/dog/mati3.png
createMaskedPng	${dSRC}/bitmaps/dog/right1_dog.xbm	${dSRC}/bitmasks/dog/right1_dog_mask.xbm	${dDEST}/dog/right1.png
createMaskedPng	${dSRC}/bitmaps/dog/right2_dog.xbm	${dSRC}/bitmasks/dog/right2_dog_mask.xbm	${dDEST}/dog/right2.png
createMaskedPng	${dSRC}/bitmaps/dog/rtogi1_dog.xbm	${dSRC}/bitmasks/dog/rtogi1_dog_mask.xbm	${dDEST}/dog/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/rtogi2_dog.xbm	${dSRC}/bitmasks/dog/rtogi2_dog_mask.xbm	${dDEST}/dog/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/dog/sleep1_dog.xbm	${dSRC}/bitmasks/dog/sleep1_dog_mask.xbm	${dDEST}/dog/sleep1.png
createMaskedPng	${dSRC}/bitmaps/dog/sleep2_dog.xbm	${dSRC}/bitmasks/dog/sleep2_dog_mask.xbm	${dDEST}/dog/sleep2.png
createMaskedPng	${dSRC}/bitmaps/dog/up1_dog.xbm		${dSRC}/bitmasks/dog/up1_dog_mask.xbm		${dDEST}/dog/up1.png
createMaskedPng	${dSRC}/bitmaps/dog/up2_dog.xbm		${dSRC}/bitmasks/dog/up2_dog_mask.xbm		${dDEST}/dog/up2.png
createMaskedPng	${dSRC}/bitmaps/dog/upleft1_dog.xbm	${dSRC}/bitmasks/dog/upleft1_dog_mask.xbm	${dDEST}/dog/upleft1.png
createMaskedPng	${dSRC}/bitmaps/dog/upleft2_dog.xbm	${dSRC}/bitmasks/dog/upleft2_dog_mask.xbm	${dDEST}/dog/upleft2.png
createMaskedPng	${dSRC}/bitmaps/dog/upright1_dog.xbm	${dSRC}/bitmasks/dog/upright1_dog_mask.xbm	${dDEST}/dog/upright1.png
createMaskedPng	${dSRC}/bitmaps/dog/upright2_dog.xbm	${dSRC}/bitmasks/dog/upright2_dog_mask.xbm	${dDEST}/dog/upright2.png
createMaskedPng	${dSRC}/bitmaps/dog/utogi1_dog.xbm	${dSRC}/bitmasks/dog/utogi1_dog_mask.xbm	${dDEST}/dog/utogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/utogi2_dog.xbm	${dSRC}/bitmasks/dog/utogi2_dog_mask.xbm	${dDEST}/dog/utogi2.png

#----------------------------------------------------------------
echo dog_jl4l
mkdir -p ${dDEST}/dog_jl4l
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/awake_dog.xbm		${dSRC}/bitmasks/dog/jl4l/awake_dog_mask.xbm		${dDEST}/dog_jl4l/awake.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/down1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/down1_dog_mask.xbm		${dDEST}/dog_jl4l/down1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/down2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/down2_dog_mask.xbm		${dDEST}/dog_jl4l/down2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/dtogi1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/dtogi1_dog_mask.xbm		${dDEST}/dog_jl4l/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/dtogi2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/dtogi2_dog_mask.xbm		${dDEST}/dog_jl4l/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/dwleft1_dog.xbm	${dSRC}/bitmasks/dog/jl4l/dwleft1_dog_mask.xbm		${dDEST}/dog_jl4l/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/dwleft2_dog.xbm	${dSRC}/bitmasks/dog/jl4l/dwleft2_dog_mask.xbm		${dDEST}/dog_jl4l/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/dwright1_dog.xbm	${dSRC}/bitmasks/dog/jl4l/dwright1_dog_mask.xbm		${dDEST}/dog_jl4l/dwright1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/dwright2_dog.xbm	${dSRC}/bitmasks/dog/jl4l/dwright2_dog_mask.xbm		${dDEST}/dog_jl4l/dwright2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/jare2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/jare2_dog_mask.xbm		${dDEST}/dog_jl4l/jare2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/kaki1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/kaki1_dog_mask.xbm		${dDEST}/dog_jl4l/kaki1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/kaki2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/kaki2_dog_mask.xbm		${dDEST}/dog_jl4l/kaki2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/left1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/left1_dog_mask.xbm		${dDEST}/dog_jl4l/left1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/left2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/left2_dog_mask.xbm		${dDEST}/dog_jl4l/left2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/ltogi1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/ltogi1_dog_mask.xbm		${dDEST}/dog_jl4l/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/ltogi2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/ltogi2_dog_mask.xbm		${dDEST}/dog_jl4l/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/mati2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/mati2_dog_mask.xbm		${dDEST}/dog_jl4l/mati2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/mati3_dog.xbm		${dSRC}/bitmasks/dog/jl4l/mati3_dog_mask.xbm		${dDEST}/dog_jl4l/mati3.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/right1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/right1_dog_mask.xbm		${dDEST}/dog_jl4l/right1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/right2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/right2_dog_mask.xbm		${dDEST}/dog_jl4l/right2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/rtogi1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/rtogi1_dog_mask.xbm		${dDEST}/dog_jl4l/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/rtogi2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/rtogi2_dog_mask.xbm		${dDEST}/dog_jl4l/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/sleep1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/sleep1_dog_mask.xbm		${dDEST}/dog_jl4l/sleep1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/sleep2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/sleep2_dog_mask.xbm		${dDEST}/dog_jl4l/sleep2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/up1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/up1_dog_mask.xbm		${dDEST}/dog_jl4l/up1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/up2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/up2_dog_mask.xbm		${dDEST}/dog_jl4l/up2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/upleft1_dog.xbm	${dSRC}/bitmasks/dog/jl4l/upleft1_dog_mask.xbm		${dDEST}/dog_jl4l/upleft1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/upleft2_dog.xbm	${dSRC}/bitmasks/dog/jl4l/upleft2_dog_mask.xbm		${dDEST}/dog_jl4l/upleft2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/upright1_dog.xbm	${dSRC}/bitmasks/dog/jl4l/upright1_dog_mask.xbm		${dDEST}/dog_jl4l/upright1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/upright2_dog.xbm	${dSRC}/bitmasks/dog/jl4l/upright2_dog_mask.xbm		${dDEST}/dog_jl4l/upright2.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/utogi1_dog.xbm		${dSRC}/bitmasks/dog/jl4l/utogi1_dog_mask.xbm		${dDEST}/dog_jl4l/utogi1.png
createMaskedPng	${dSRC}/bitmaps/dog/jl4l/utogi2_dog.xbm		${dSRC}/bitmasks/dog/jl4l/utogi2_dog_mask.xbm		${dDEST}/dog_jl4l/utogi2.png
#createMaskedPng	${dSRC}/bitmaps/dog/jl4l/cursor.xbm	${dSRC}/bitmasks/dog/jl4l/cursor_mask.xbm		${dDEST}/dog_jl4l/cursor.png

#----------------------------------------------------------------
echo neko
mkdir -p ${dDEST}/neko
createMaskedPng	${dSRC}/bitmaps/neko/awake.xbm		${dSRC}/bitmasks/neko/awake_mask.xbm		${dDEST}/neko/awake.png
createMaskedPng	${dSRC}/bitmaps/neko/down1.xbm		${dSRC}/bitmasks/neko/down1_mask.xbm		${dDEST}/neko/down1.png
createMaskedPng	${dSRC}/bitmaps/neko/down2.xbm		${dSRC}/bitmasks/neko/down2_mask.xbm		${dDEST}/neko/down2.png
createMaskedPng	${dSRC}/bitmaps/neko/dtogi1.xbm		${dSRC}/bitmasks/neko/dtogi1_mask.xbm		${dDEST}/neko/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/neko/dtogi2.xbm		${dSRC}/bitmasks/neko/dtogi2_mask.xbm		${dDEST}/neko/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/neko/dwleft1.xbm	${dSRC}/bitmasks/neko/dwleft1_mask.xbm		${dDEST}/neko/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/neko/dwleft2.xbm	${dSRC}/bitmasks/neko/dwleft2_mask.xbm		${dDEST}/neko/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/neko/dwright1.xbm	${dSRC}/bitmasks/neko/dwright1_mask.xbm		${dDEST}/neko/dwright1.png
createMaskedPng	${dSRC}/bitmaps/neko/dwright2.xbm	${dSRC}/bitmasks/neko/dwright2_mask.xbm		${dDEST}/neko/dwright2.png
createMaskedPng	${dSRC}/bitmaps/neko/jare2.xbm		${dSRC}/bitmasks/neko/jare2_mask.xbm		${dDEST}/neko/jare2.png
createMaskedPng	${dSRC}/bitmaps/neko/kaki1.xbm		${dSRC}/bitmasks/neko/kaki1_mask.xbm		${dDEST}/neko/kaki1.png
createMaskedPng	${dSRC}/bitmaps/neko/kaki2.xbm		${dSRC}/bitmasks/neko/kaki2_mask.xbm		${dDEST}/neko/kaki2.png
createMaskedPng	${dSRC}/bitmaps/neko/left1.xbm		${dSRC}/bitmasks/neko/left1_mask.xbm		${dDEST}/neko/left1.png
createMaskedPng	${dSRC}/bitmaps/neko/left2.xbm		${dSRC}/bitmasks/neko/left2_mask.xbm		${dDEST}/neko/left2.png
createMaskedPng	${dSRC}/bitmaps/neko/ltogi1.xbm		${dSRC}/bitmasks/neko/ltogi1_mask.xbm		${dDEST}/neko/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/neko/ltogi2.xbm		${dSRC}/bitmasks/neko/ltogi2_mask.xbm		${dDEST}/neko/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/neko/mati2.xbm		${dSRC}/bitmasks/neko/mati2_mask.xbm		${dDEST}/neko/mati2.png
createMaskedPng	${dSRC}/bitmaps/neko/mati3.xbm		${dSRC}/bitmasks/neko/mati3_mask.xbm		${dDEST}/neko/mati3.png
createMaskedPng	${dSRC}/bitmaps/neko/right1.xbm		${dSRC}/bitmasks/neko/right1_mask.xbm		${dDEST}/neko/right1.png
createMaskedPng	${dSRC}/bitmaps/neko/right2.xbm		${dSRC}/bitmasks/neko/right2_mask.xbm		${dDEST}/neko/right2.png
createMaskedPng	${dSRC}/bitmaps/neko/rtogi1.xbm		${dSRC}/bitmasks/neko/rtogi1_mask.xbm		${dDEST}/neko/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/neko/rtogi2.xbm		${dSRC}/bitmasks/neko/rtogi2_mask.xbm		${dDEST}/neko/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/neko/sleep1.xbm		${dSRC}/bitmasks/neko/sleep1_mask.xbm		${dDEST}/neko/sleep1.png
createMaskedPng	${dSRC}/bitmaps/neko/sleep2.xbm		${dSRC}/bitmasks/neko/sleep2_mask.xbm		${dDEST}/neko/sleep2.png
createMaskedPng	${dSRC}/bitmaps/neko/up1.xbm		${dSRC}/bitmasks/neko/up1_mask.xbm		${dDEST}/neko/up1.png
createMaskedPng	${dSRC}/bitmaps/neko/up2.xbm		${dSRC}/bitmasks/neko/up2_mask.xbm		${dDEST}/neko/up2.png
createMaskedPng	${dSRC}/bitmaps/neko/upleft1.xbm	${dSRC}/bitmasks/neko/upleft1_mask.xbm		${dDEST}/neko/upleft1.png
createMaskedPng	${dSRC}/bitmaps/neko/upleft2.xbm	${dSRC}/bitmasks/neko/upleft2_mask.xbm		${dDEST}/neko/upleft2.png
createMaskedPng	${dSRC}/bitmaps/neko/upright1.xbm	${dSRC}/bitmasks/neko/upright1_mask.xbm		${dDEST}/neko/upright1.png
createMaskedPng	${dSRC}/bitmaps/neko/upright2.xbm	${dSRC}/bitmasks/neko/upright2_mask.xbm		${dDEST}/neko/upright2.png
createMaskedPng	${dSRC}/bitmaps/neko/utogi1.xbm		${dSRC}/bitmasks/neko/utogi1_mask.xbm		${dDEST}/neko/utogi1.png
createMaskedPng	${dSRC}/bitmaps/neko/utogi2.xbm		${dSRC}/bitmasks/neko/utogi2_mask.xbm		${dDEST}/neko/utogi2.png

#----------------------------------------------------------------
echo sakura
mkdir -p ${dDEST}/sakura
createMaskedPng	${dSRC}/bitmaps/sakura/awake_sakura.xbm		${dSRC}/bitmasks/sakura/awake_sakura_mask.xbm		${dDEST}/sakura/awake.png
createMaskedPng	${dSRC}/bitmaps/sakura/down1_sakura.xbm		${dSRC}/bitmasks/sakura/down1_sakura_mask.xbm		${dDEST}/sakura/down1.png
createMaskedPng	${dSRC}/bitmaps/sakura/down2_sakura.xbm		${dSRC}/bitmasks/sakura/down2_sakura_mask.xbm		${dDEST}/sakura/down2.png
createMaskedPng	${dSRC}/bitmaps/sakura/dtogi1_sakura.xbm	${dSRC}/bitmasks/sakura/dtogi1_sakura_mask.xbm		${dDEST}/sakura/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/sakura/dtogi2_sakura.xbm	${dSRC}/bitmasks/sakura/dtogi2_sakura_mask.xbm		${dDEST}/sakura/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/sakura/dwleft1_sakura.xbm	${dSRC}/bitmasks/sakura/dwleft1_sakura_mask.xbm		${dDEST}/sakura/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/sakura/dwleft2_sakura.xbm	${dSRC}/bitmasks/sakura/dwleft2_sakura_mask.xbm		${dDEST}/sakura/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/sakura/dwright1_sakura.xbm	${dSRC}/bitmasks/sakura/dwright1_sakura_mask.xbm	${dDEST}/sakura/dwright1.png
createMaskedPng	${dSRC}/bitmaps/sakura/dwright2_sakura.xbm	${dSRC}/bitmasks/sakura/dwright2_sakura_mask.xbm	${dDEST}/sakura/dwright2.png
createMaskedPng	${dSRC}/bitmaps/sakura/jare2_sakura.xbm		${dSRC}/bitmasks/sakura/jare2_sakura_mask.xbm		${dDEST}/sakura/jare2.png
createMaskedPng	${dSRC}/bitmaps/sakura/kaki1_sakura.xbm		${dSRC}/bitmasks/sakura/kaki1_sakura_mask.xbm		${dDEST}/sakura/kaki1.png
createMaskedPng	${dSRC}/bitmaps/sakura/kaki2_sakura.xbm		${dSRC}/bitmasks/sakura/kaki2_sakura_mask.xbm		${dDEST}/sakura/kaki2.png
createMaskedPng	${dSRC}/bitmaps/sakura/left1_sakura.xbm		${dSRC}/bitmasks/sakura/left1_sakura_mask.xbm		${dDEST}/sakura/left1.png
createMaskedPng	${dSRC}/bitmaps/sakura/left2_sakura.xbm		${dSRC}/bitmasks/sakura/left2_sakura_mask.xbm		${dDEST}/sakura/left2.png
createMaskedPng	${dSRC}/bitmaps/sakura/ltogi1_sakura.xbm	${dSRC}/bitmasks/sakura/ltogi1_sakura_mask.xbm		${dDEST}/sakura/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/sakura/ltogi2_sakura.xbm	${dSRC}/bitmasks/sakura/ltogi2_sakura_mask.xbm		${dDEST}/sakura/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/sakura/mati2_sakura.xbm		${dSRC}/bitmasks/sakura/mati2_sakura_mask.xbm		${dDEST}/sakura/mati2.png
createMaskedPng	${dSRC}/bitmaps/sakura/mati3_sakura.xbm		${dSRC}/bitmasks/sakura/mati3_sakura_mask.xbm		${dDEST}/sakura/mati3.png
createMaskedPng	${dSRC}/bitmaps/sakura/right1_sakura.xbm	${dSRC}/bitmasks/sakura/right1_sakura_mask.xbm		${dDEST}/sakura/right1.png
createMaskedPng	${dSRC}/bitmaps/sakura/right2_sakura.xbm	${dSRC}/bitmasks/sakura/right2_sakura_mask.xbm		${dDEST}/sakura/right2.png
createMaskedPng	${dSRC}/bitmaps/sakura/rtogi1_sakura.xbm	${dSRC}/bitmasks/sakura/rtogi1_sakura_mask.xbm		${dDEST}/sakura/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/sakura/rtogi2_sakura.xbm	${dSRC}/bitmasks/sakura/rtogi2_sakura_mask.xbm		${dDEST}/sakura/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/sakura/sleep1_sakura.xbm	${dSRC}/bitmasks/sakura/sleep1_sakura_mask.xbm		${dDEST}/sakura/sleep1.png
createMaskedPng	${dSRC}/bitmaps/sakura/sleep2_sakura.xbm	${dSRC}/bitmasks/sakura/sleep2_sakura_mask.xbm		${dDEST}/sakura/sleep2.png
createMaskedPng	${dSRC}/bitmaps/sakura/up1_sakura.xbm		${dSRC}/bitmasks/sakura/up1_sakura_mask.xbm		${dDEST}/sakura/up1.png
createMaskedPng	${dSRC}/bitmaps/sakura/up2_sakura.xbm		${dSRC}/bitmasks/sakura/up2_sakura_mask.xbm		${dDEST}/sakura/up2.png
createMaskedPng	${dSRC}/bitmaps/sakura/upleft1_sakura.xbm	${dSRC}/bitmasks/sakura/upleft1_sakura_mask.xbm		${dDEST}/sakura/upleft1.png
createMaskedPng	${dSRC}/bitmaps/sakura/upleft2_sakura.xbm	${dSRC}/bitmasks/sakura/upleft2_sakura_mask.xbm		${dDEST}/sakura/upleft2.png
createMaskedPng	${dSRC}/bitmaps/sakura/upright1_sakura.xbm	${dSRC}/bitmasks/sakura/upright1_sakura_mask.xbm	${dDEST}/sakura/upright1.png
createMaskedPng	${dSRC}/bitmaps/sakura/upright2_sakura.xbm	${dSRC}/bitmasks/sakura/upright2_sakura_mask.xbm	${dDEST}/sakura/upright2.png
createMaskedPng	${dSRC}/bitmaps/sakura/utogi1_sakura.xbm	${dSRC}/bitmasks/sakura/utogi1_sakura_mask.xbm		${dDEST}/sakura/utogi1.png
createMaskedPng	${dSRC}/bitmaps/sakura/utogi2_sakura.xbm	${dSRC}/bitmasks/sakura/utogi2_sakura_mask.xbm		${dDEST}/sakura/utogi2.png

#----------------------------------------------------------------
echo tomoyo
mkdir -p ${dDEST}/tomoyo
createMaskedPng	${dSRC}/bitmaps/tomoyo/awake_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/awake_tomoyo_mask.xbm		${dDEST}/tomoyo/awake.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/down1_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/down1_tomoyo_mask.xbm		${dDEST}/tomoyo/down1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/down2_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/down2_tomoyo_mask.xbm		${dDEST}/tomoyo/down2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/dtogi1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/dtogi1_tomoyo_mask.xbm		${dDEST}/tomoyo/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/dtogi2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/dtogi2_tomoyo_mask.xbm		${dDEST}/tomoyo/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/dwleft1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/dwleft1_tomoyo_mask.xbm		${dDEST}/tomoyo/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/dwleft2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/dwleft2_tomoyo_mask.xbm		${dDEST}/tomoyo/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/dwright1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/dwright1_tomoyo_mask.xbm	${dDEST}/tomoyo/dwright1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/dwright2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/dwright2_tomoyo_mask.xbm	${dDEST}/tomoyo/dwright2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/jare2_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/jare2_tomoyo_mask.xbm		${dDEST}/tomoyo/jare2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/kaki1_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/kaki1_tomoyo_mask.xbm		${dDEST}/tomoyo/kaki1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/kaki2_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/kaki2_tomoyo_mask.xbm		${dDEST}/tomoyo/kaki2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/left1_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/left1_tomoyo_mask.xbm		${dDEST}/tomoyo/left1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/left2_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/left2_tomoyo_mask.xbm		${dDEST}/tomoyo/left2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/ltogi1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/ltogi1_tomoyo_mask.xbm		${dDEST}/tomoyo/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/ltogi2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/ltogi2_tomoyo_mask.xbm		${dDEST}/tomoyo/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/mati2_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/mati2_tomoyo_mask.xbm		${dDEST}/tomoyo/mati2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/mati3_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/mati3_tomoyo_mask.xbm		${dDEST}/tomoyo/mati3.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/right1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/right1_tomoyo_mask.xbm		${dDEST}/tomoyo/right1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/right2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/right2_tomoyo_mask.xbm		${dDEST}/tomoyo/right2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/rtogi1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/rtogi1_tomoyo_mask.xbm		${dDEST}/tomoyo/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/rtogi2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/rtogi2_tomoyo_mask.xbm		${dDEST}/tomoyo/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/sleep1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/sleep1_tomoyo_mask.xbm		${dDEST}/tomoyo/sleep1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/sleep2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/sleep2_tomoyo_mask.xbm		${dDEST}/tomoyo/sleep2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/up1_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/up1_tomoyo_mask.xbm		${dDEST}/tomoyo/up1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/up2_tomoyo.xbm		${dSRC}/bitmasks/tomoyo/up2_tomoyo_mask.xbm		${dDEST}/tomoyo/up2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/upleft1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/upleft1_tomoyo_mask.xbm		${dDEST}/tomoyo/upleft1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/upleft2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/upleft2_tomoyo_mask.xbm		${dDEST}/tomoyo/upleft2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/upright1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/upright1_tomoyo_mask.xbm	${dDEST}/tomoyo/upright1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/upright2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/upright2_tomoyo_mask.xbm	${dDEST}/tomoyo/upright2.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/utogi1_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/utogi1_tomoyo_mask.xbm		${dDEST}/tomoyo/utogi1.png
createMaskedPng	${dSRC}/bitmaps/tomoyo/utogi2_tomoyo.xbm	${dSRC}/bitmasks/tomoyo/utogi2_tomoyo_mask.xbm		${dDEST}/tomoyo/utogi2.png

#----------------------------------------------------------------
echo tora
mkdir -p ${dDEST}/tora
createMaskedPng	${dSRC}/bitmaps/tora/awake_tora.xbm	${dSRC}/bitmasks/neko/awake_mask.xbm	${dDEST}/tora/awake.png
createMaskedPng	${dSRC}/bitmaps/tora/down1_tora.xbm	${dSRC}/bitmasks/neko/down1_mask.xbm	${dDEST}/tora/down1.png
createMaskedPng	${dSRC}/bitmaps/tora/down2_tora.xbm	${dSRC}/bitmasks/neko/down2_mask.xbm	${dDEST}/tora/down2.png
createMaskedPng	${dSRC}/bitmaps/tora/dtogi1_tora.xbm	${dSRC}/bitmasks/neko/dtogi1_mask.xbm	${dDEST}/tora/dtogi1.png
createMaskedPng	${dSRC}/bitmaps/tora/dtogi2_tora.xbm	${dSRC}/bitmasks/neko/dtogi2_mask.xbm	${dDEST}/tora/dtogi2.png
createMaskedPng	${dSRC}/bitmaps/tora/dwleft1_tora.xbm	${dSRC}/bitmasks/neko/dwleft1_mask.xbm	${dDEST}/tora/dwleft1.png
createMaskedPng	${dSRC}/bitmaps/tora/dwleft2_tora.xbm	${dSRC}/bitmasks/neko/dwleft2_mask.xbm	${dDEST}/tora/dwleft2.png
createMaskedPng	${dSRC}/bitmaps/tora/dwright1_tora.xbm	${dSRC}/bitmasks/neko/dwright1_mask.xbm	${dDEST}/tora/dwright1.png
createMaskedPng	${dSRC}/bitmaps/tora/dwright2_tora.xbm	${dSRC}/bitmasks/neko/dwright2_mask.xbm	${dDEST}/tora/dwright2.png
createMaskedPng	${dSRC}/bitmaps/tora/jare2_tora.xbm	${dSRC}/bitmasks/neko/jare2_mask.xbm	${dDEST}/tora/jare2.png
createMaskedPng	${dSRC}/bitmaps/tora/kaki1_tora.xbm	${dSRC}/bitmasks/neko/kaki1_mask.xbm	${dDEST}/tora/kaki1.png
createMaskedPng	${dSRC}/bitmaps/tora/kaki2_tora.xbm	${dSRC}/bitmasks/neko/kaki2_mask.xbm	${dDEST}/tora/kaki2.png
createMaskedPng	${dSRC}/bitmaps/tora/left1_tora.xbm	${dSRC}/bitmasks/neko/left1_mask.xbm	${dDEST}/tora/left1.png
createMaskedPng	${dSRC}/bitmaps/tora/left2_tora.xbm	${dSRC}/bitmasks/neko/left2_mask.xbm	${dDEST}/tora/left2.png
createMaskedPng	${dSRC}/bitmaps/tora/ltogi1_tora.xbm	${dSRC}/bitmasks/neko/ltogi1_mask.xbm	${dDEST}/tora/ltogi1.png
createMaskedPng	${dSRC}/bitmaps/tora/ltogi2_tora.xbm	${dSRC}/bitmasks/neko/ltogi2_mask.xbm	${dDEST}/tora/ltogi2.png
createMaskedPng	${dSRC}/bitmaps/tora/mati2_tora.xbm	${dSRC}/bitmasks/neko/mati2_mask.xbm	${dDEST}/tora/mati2.png
createMaskedPng	${dSRC}/bitmaps/tora/mati3_tora.xbm	${dSRC}/bitmasks/neko/mati3_mask.xbm	${dDEST}/tora/mati3.png
createMaskedPng	${dSRC}/bitmaps/tora/right1_tora.xbm	${dSRC}/bitmasks/neko/right1_mask.xbm	${dDEST}/tora/right1.png
createMaskedPng	${dSRC}/bitmaps/tora/right2_tora.xbm	${dSRC}/bitmasks/neko/right2_mask.xbm	${dDEST}/tora/right2.png
createMaskedPng	${dSRC}/bitmaps/tora/rtogi1_tora.xbm	${dSRC}/bitmasks/neko/rtogi1_mask.xbm	${dDEST}/tora/rtogi1.png
createMaskedPng	${dSRC}/bitmaps/tora/rtogi2_tora.xbm	${dSRC}/bitmasks/neko/rtogi2_mask.xbm	${dDEST}/tora/rtogi2.png
createMaskedPng	${dSRC}/bitmaps/tora/sleep1_tora.xbm	${dSRC}/bitmasks/neko/sleep1_mask.xbm	${dDEST}/tora/sleep1.png
createMaskedPng	${dSRC}/bitmaps/tora/sleep2_tora.xbm	${dSRC}/bitmasks/neko/sleep2_mask.xbm	${dDEST}/tora/sleep2.png
createMaskedPng	${dSRC}/bitmaps/tora/up1_tora.xbm	${dSRC}/bitmasks/neko/up1_mask.xbm	${dDEST}/tora/up1.png
createMaskedPng	${dSRC}/bitmaps/tora/up2_tora.xbm	${dSRC}/bitmasks/neko/up2_mask.xbm	${dDEST}/tora/up2.png
createMaskedPng	${dSRC}/bitmaps/tora/upleft1_tora.xbm	${dSRC}/bitmasks/neko/upleft1_mask.xbm	${dDEST}/tora/upleft1.png
createMaskedPng	${dSRC}/bitmaps/tora/upleft2_tora.xbm	${dSRC}/bitmasks/neko/upleft2_mask.xbm	${dDEST}/tora/upleft2.png
createMaskedPng	${dSRC}/bitmaps/tora/upright1_tora.xbm	${dSRC}/bitmasks/neko/upright1_mask.xbm	${dDEST}/tora/upright1.png
createMaskedPng	${dSRC}/bitmaps/tora/upright2_tora.xbm	${dSRC}/bitmasks/neko/upright2_mask.xbm	${dDEST}/tora/upright2.png
createMaskedPng	${dSRC}/bitmaps/tora/utogi1_tora.xbm	${dSRC}/bitmasks/neko/utogi1_mask.xbm	${dDEST}/tora/utogi1.png
createMaskedPng	${dSRC}/bitmaps/tora/utogi2_tora.xbm	${dSRC}/bitmasks/neko/utogi2_mask.xbm	${dDEST}/tora/utogi2.png

#----------------------------------------------------------------
echo '---done---'

#!/bin/bash
dSRC=src/kreativekorp
dDEST=bitmaps/kreativekorp

#----------------------------------------------------------------
echo "---convert: ${dSRC}---"

#----------------------------------------------------------------
mkdir -p ${dDEST}

#----------------------------------------------------------------

icls="\
    Alien.icl \
    BUG.icl \
    Black.icl \
    Black2.icl \
    BlueMarine.icl \
    Blue_Tabby.icl \
    BooBooKitty.icl \
    Brown_BSD_Daemon.icl \
    Brown_Dog.icl \
    CLORPOIN.icl \
    Calico_Tabby.icl \
    Caz.icl \
    Chocobo.icl \
    Coke_Bottle.icl \
    DALMY.icl \
    DeeDee.icl \
    Dog.icl \
    Doom.icl \
    FOX.icl \
    Face.icl \
    Green_Ghost.icl \
    KITTY.icl \
    Lucy_Dog.icl \
    MOON.icl \
    Metroid.icl \
    Mini.icl \
    Monster_Truck.icl \
    Multi.icl \
    Pac_Man.icl \
    Penguin.icl \
    Penguin_2.icl \
    Pink_Nose_Neko.icl \
    Red_BSD_Daemon.icl \
    Rocket.icl \
    Skunk.icl \
    Tabby.icl \
    Tentacle.icl \
    Tie_Fighter.icl \
    Worms.icl \
    captain_goodnight.icl \
    ff3mog.icl \
    nekocool.icl \
    zelda3.icl
"

#------------------------------------------------------------
for i in ${icls}; do
    name=$(basename $i .icl)
    echo $name
    
    mkdir -p ${dDEST}/${name}/ico;

    wrestool  --extract --type=14 --output=${dDEST}/${name}/ico/ ${dSRC}/${i}

    (
	# FYI: Turtle and Sonic icon have 2 frames. Need to select first one
	cd ${dDEST}/${name}/ico/
	for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32; do
	    convert ${name}.icl_14_${n}.ico[0] PNG32:${n}.png
	done

	mv 1.png ../awake.png
	mv 2.png ../up1.png
	mv 3.png ../up2.png
	mv 4.png ../upright1.png
	mv 5.png ../upright2.png
	mv 6.png ../right1.png
	mv 7.png ../right2.png
	mv 8.png ../dwright2.png
	mv 9.png ../dwright1.png
	mv 10.png ../down1.png
	mv 11.png ../down2.png
	mv 12.png ../dwleft2.png
	mv 13.png ../dwleft1.png
	mv 14.png ../left1.png
	mv 15.png ../left2.png
	mv 16.png ../upleft1.png
	mv 17.png ../upleft2.png
	mv 18.png ../utogi1.png
	mv 19.png ../utogi2.png
	mv 20.png ../rtogi2.png
	mv 21.png ../rtogi1.png
	mv 22.png ../ltogi1.png
	mv 23.png ../ltogi2.png
	mv 24.png ../dtogi1.png
	mv 25.png ../dtogi2.png
	mv 26.png ../jare2.png
	mv 27.png ../kaki1.png
	mv 28.png ../kaki2.png
	mv 29.png ../mati2.png
	mv 30.png ../mati3.png
	mv 31.png ../sleep1.png
	mv 32.png ../sleep2.png
	#mv 33.png ../space.png
    )
done




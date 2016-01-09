#
#
#

DLs=\
	dl/oneko-1.2.sakura.5.tar.gz\
	dl/kreativekorp/neko/images.zip \
	dl/X11_R5contrib/xneko.tar.Z

all:  bitmaps/oneko/neko/awake.png bitmaps/kreativekorp/nekocool/awake.png $(DLs) src/X11_R5contrib_xneko/.extract

clean:
	rm -rf bitmaps/kreativekorp bitmaps/oneko src/*
	rm -f *~

veryclean: clean
	rm -rf dl

#----------------
# http://www.daidouji.com/oneko/
dl/oneko-1.2.sakura.5.tar.gz:
	-mkdir dl
	cd dl; curl -O http://www.daidouji.com/oneko/distfiles/oneko-1.2.sakura.5.tar.gz

src/oneko-1.2.sakura.5/.extract: dl/oneko-1.2.sakura.5.tar.gz
	mkdir -p src/oneko-1.2.sakura.5
	cat $< | (cd src; tar -xzf -)
	date > $@

bitmaps/oneko/neko/awake.png: src/oneko-1.2.sakura.5/.extract
	bash bin/oneko-1.2.sakura.5.convert.sh

#----------------
dl/kreativekorp/neko/images.zip:
	-mkdir -p dl/kreativekorp/neko
	cd dl/kreativekorp/neko; curl -O http://www.kreativekorp.com/swdownload/archive/neko/images.zip

src/kreativekorp/.extract: dl/kreativekorp/neko/images.zip
	-mkdir -p src/kreativekorp
	unzip -d src/kreativekorp/ $<
	chmod 600 src/kreativekorp/*
	( cd src/kreativekorp; \
		mv 'BUG.ICL' BUG.icl ;\
		mv 'Blue Tabby.icl' Blue_Tabby.icl; \
		mv 'Brown BSD Daemon.icl' Brown_BSD_Daemon.icl; \
		mv 'Brown Dog.icl' Brown_Dog.icl; \
		mv 'CLORPOIN.ICL' CLORPOIN.icl; \
		mv 'Calico Tabby.icl' Calico_Tabby.icl; \
		mv 'Chocobo.ICL' Chocobo.icl; \
		mv 'Coke Bottle.icl' Coke_Bottle.icl; \
		mv 'DALMY.ICL' DALMY.icl; \
		mv 'FOX.ICL' FOX.icl; \
		mv 'Green Ghost.icl' Green_Ghost.icl; \
		mv 'KITTY.ICL' KITTY.icl; \
		mv 'Lucy Dog.icl' Lucy_Dog.icl;\
		mv 'MOON.ICL' MOON.icl; \
		mv 'Monster Truck.ICL' Monster_Truck.icl; \
		mv 'Pac Man.icl' Pac_Man.icl; \
		mv 'Penguin 2.icl' Penguin_2.icl; \
		mv 'Pink Nose Neko.icl' Pink_Nose_Neko.icl; \
		mv 'Red BSD Daemon.icl' Red_BSD_Daemon.icl; \
		mv 'Tie Fighter.icl' Tie_Fighter.icl; \
	)
	date > $@

bitmaps/kreativekorp/nekocool/awake.png: src/kreativekorp/.extract
	bash bin/kreativekorp_neko_bimage.convert.sh

#----------------
dl/X11_R5contrib/xneko.tar.Z:
	-mkdir dl/X11_R5contrib
	cd dl/X11_R5contrib && curl -O http://ftp.x.org/R5contrib/xneko.tar.Z

src/X11_R5contrib_xneko/.extract: dl/X11_R5contrib/xneko.tar.Z
	-mkdir -p src/X11_R5contrib_xneko
	cat $< | (cd src/X11_R5contrib_xneko; tar -xvzf -)
	date > $@

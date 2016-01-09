var hasLoadedWindow = false;
var hasLoadedEmscripten = false;

var SCREEN_WIDTH=(640)
var SCREEN_HEIGHT=(320)
var BITMAP_WIDTH=(32)
var BITMAP_HEIGHT=(32)

var NUMCHASER=(8)
var framesPerSecond=(10)

var Chasers = new Array();

var animationpattern =[
    { "tickodd":"img/mati2.png",    "tickeven":"img/mati2.png" },	/* state == CHASER_STOP */
    { "tickodd":"img/jare2.png",    "tickeven":"img/mati2.png" },	/* state == CHASER_JARE */
    { "tickodd":"img/kaki1.png",    "tickeven":"img/kaki2.png" },	/* state == CHASER_KAKI */
    { "tickodd":"img/mati3.png",    "tickeven":"img/mati3.png" },	/* state == CHASER_AKUBI */
    { "tickodd":"img/sleep1.png",   "tickeven":"img/sleep2.png" },	/* state == CHASER_SLEEP */
    { "tickodd":"img/awake.png",    "tickeven":"img/awake.png" },	/* state == CHASER_AWAKE */

    { "tickodd":"img/up1.png",      "tickeven":"img/up2.png" },	/* state == CHASER_U_MOVE */
    { "tickodd":"img/down1.png",    "tickeven":"img/down2.png" },	/* state == CHASER_D_MOVE */
    { "tickodd":"img/left1.png",    "tickeven":"img/left2.png" },	/* state == CHASER_L_MOVE */
    { "tickodd":"img/right1.png",   "tickeven":"img/right2.png" },	/* state == CHASER_R_MOVE */

    { "tickodd":"img/upleft1.png",  "tickeven":"img/upleft2.png" },	/* state == CHASER_UL_MOVE */
    { "tickodd":"img/upright1.png", "tickeven":"img/upright2.png" },	/* state == CHASER_UR_MOVE */
    { "tickodd":"img/dwleft1.png",  "tickeven":"img/dwleft2.png" },	/* state == CHASER_DL_MOVE */
    { "tickodd":"img/dwright1.png", "tickeven":"img/dwright2.png" },	/* state == CHASER_DR_MOVE */

    { "tickodd":"img/utogi1.png",   "tickeven":"img/utogi2.png" },	/* state == CHASER_U_TOGI */
    { "tickodd":"img/dtogi1.png",   "tickeven":"img/dtogi2.png" },	/* state == CHASER_D_TOGI */
    { "tickodd":"img/ltogi1.png",   "tickeven":"img/ltogi2.png" },	/* state == CHASER_L_TOGI */
    { "tickodd":"img/rtogi1.png",   "tickeven":"img/rtogi2.png" },	/* state == CHASER_R_TOGI */
];

function setup(){
    for (var i = 0; i < NUMCHASER; i++){
	var chaser=new Object();
	chaser.c=new Module.ChaserObj(0,0,(SCREEN_WIDTH-BITMAP_WIDTH),(SCREEN_HEIGHT-BITMAP_HEIGHT));
	chaser.name="chaser"+i;
	Chasers.push(chaser);
    }

    // run the chasers through a few interation to put them in a "random" spots.
    for (var n = 0; n < 50; n++){ update(); }
}

function setup_doc(){
    Chasers.forEach(function(chaser){
	elem = document.createElement("img");
	elem.setAttribute('id', chaser.name);
        elem.style.position='absolute';
	elem.style.left=0;
	elem.style.top=0;
	
	elem.setAttribute('height', BITMAP_HEIGHT);
	elem.setAttribute('width',  BITMAP_WIDTH);
	elem.setAttribute('src', 'img/awake.png');
	document.getElementById("grass").appendChild(elem);
    });
}

function update() {
    Chasers.forEach(function(chaser){ chaser.c.think(); });
}

function loop(){
    Chasers.forEach(function(chaser){
	s=document.getElementById(chaser.name)
	s.style.left=chaser.c.c.x+"px"
	s.style.top=chaser.c.c.y+"px"

	if ( chaser.c.c.state != Module.CHASER_SLEEP ) {
	    cimg=((chaser.c.c.tickcount % 2 == 0 )?
		  animationpattern[chaser.c.c.state].tickeven :
		  animationpattern[chaser.c.c.state].tickodd );
	} else {
	    cimg=((chaser.c.c.tickcount % 8 <= 3) ?
		  animationpattern[chaser.c.c.state].tickeven :
		  animationpattern[chaser.c.c.state].tickodd );
	}
	s.setAttribute('src', cimg);
    });

    update();
}

function render() {
    loop();
	
    setTimeout(function(){
	requestAnimationFrame(render);
    }, 1000/framesPerSecond);
}
//################################################################
window.onload = function() {
    console.log("onload");
    hasLoadedWindow = true;
}

// EMSCRIPTEN: wait for compiled modules to load
var Module = {
    onRuntimeInitialized: function() {
	console.log("emscripten");
	hasLoadedEmscripten = true;
    }
};

function hasLoadedAll() {
    if (!hasLoadedWindow || !hasLoadedEmscripten) {
	console.log("waiting");
	window.setTimeout(hasLoadedAll, 500);
    } else {
	console.log("ready");
	setup(); //setup chasers

	var canvas = document.getElementById("grass");
	canvas.style.height=SCREEN_HEIGHT+'px'
	canvas.style.width=SCREEN_WIDTH+'px'
	canvas.style.border='1px solid #000000'
	canvas.style['background-color']='#008000'

	setup_doc(); // add chasers to document

	render();
    }
}

hasLoadedAll();

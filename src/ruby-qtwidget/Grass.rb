require "Chaser"

BITMAP_WIDTH=(32)
BITMAP_HEIGHT=(32)
FRAMESPERSECOND=(10)

NUMCHASER=(8)

CHASER_STOP=0
CHASER_JARE=1
CHASER_KAKI=2
CHASER_AKUBI=3
CHASER_SLEEP=4
CHASER_AWAKE=5
CHASER_U_MOVE=6
CHASER_D_MOVE=7
CHASER_L_MOVE=8
CHASER_R_MOVE=9
CHASER_UL_MOVE=10
CHASER_UR_MOVE=11
CHASER_DL_MOVE=12
CHASER_DR_MOVE=13
CHASER_U_TOGI=14
CHASER_D_TOGI=15
CHASER_L_TOGI=16
CHASER_R_TOGI=17

CHASER_STOP_TIME=4
CHASER_JARE_TIME=10
CHASER_KAKI_TIME=4
CHASER_AKUBI_TIME=3
CHASER_AWAKE_TIME=3
CHASER_TOGI_TIME=10
#----------------
NORMAL_STATE=1

CIMG={
  'jare2'=>Qt::Image.new("img/jare2.png"),
  'mati2'=>Qt::Image.new("img/mati2.png"),
  'kaki1'=>Qt::Image.new("img/kaki1.png"),
  'kaki2'=>Qt::Image.new("img/kaki2.png"),
  'mati3'=>Qt::Image.new("img/mati3.png"),
  'sleep1'=>Qt::Image.new("img/sleep1.png"),
  'sleep2'=>Qt::Image.new("img/sleep2.png"),
  'awake'=>Qt::Image.new("img/awake.png"),

  'up1'=>Qt::Image.new("img/up1.png"),
  'up2'=>Qt::Image.new("img/up2.png"),
  'down1'=>Qt::Image.new("img/down1.png"),
  'down2'=>Qt::Image.new("img/down2.png"),
  'left1'=>Qt::Image.new("img/left1.png"),
  'left2'=>Qt::Image.new("img/left2.png"),
  'right1'=>Qt::Image.new("img/right1.png"),
  'right2'=>Qt::Image.new("img/right2.png"),

  'upleft1'=>Qt::Image.new("img/upleft1.png"),
  'upleft2'=>Qt::Image.new("img/upleft2.png"),
  'upright1'=>Qt::Image.new("img/upright1.png"),
  'upright2'=>Qt::Image.new("img/upright2.png"),
  'dwleft1'=>Qt::Image.new("img/dwleft1.png"),
  'dwleft2'=>Qt::Image.new("img/dwleft2.png"),
  'dwright1'=>Qt::Image.new("img/dwright1.png"),
  'dwright2'=>Qt::Image.new("img/dwright2.png"),

  'dtogi1'=>Qt::Image.new("img/dtogi1.png"),
  'dtogi2'=>Qt::Image.new("img/dtogi2.png"),
  'ltogi1'=>Qt::Image.new("img/ltogi1.png"),
  'ltogi2'=>Qt::Image.new("img/ltogi2.png"),
  'rtogi1'=>Qt::Image.new("img/rtogi1.png"),
  'rtogi2'=>Qt::Image.new("img/rtogi2.png"),
  'utogi1'=>Qt::Image.new("img/utogi1.png"),
  'utogi2'=>Qt::Image.new("img/utogi2.png")
}

class Grass < Qt::Widget
  @quit=false
  @screen_height=100
  @screen_width=100
  
  def initialize(parent, width, height)
    super(parent)
    setFocusPolicy Qt::StrongFocus

    @field_height=height
    @field_width=width

    @chasers=[]
    @animationpattern=[
      { 'tickodd'=>CIMG['mati2'],    'tickeven'=>CIMG['mati2'] },	# state == CHASER_STOP
      { 'tickodd'=>CIMG['jare2'],    'tickeven'=>CIMG['mati2'] },	# state == CHASER_JARE
      { 'tickodd'=>CIMG['kaki1'],    'tickeven'=>CIMG['kaki2'] },	# state == CHASER_KAKI
      { 'tickodd'=>CIMG['mati3'],    'tickeven'=>CIMG['mati3'] },	# state == CHASER_AKUBI
      { 'tickodd'=>CIMG['sleep1'],   'tickeven'=>CIMG['sleep2'] },	# state == CHASER_SLEEP
      { 'tickodd'=>CIMG['awake'],    'tickeven'=>CIMG['awake'] },	# state == CHASER_AWAKE

      { 'tickodd'=>CIMG['up1'],      'tickeven'=>CIMG['up2'] },		# state == CHASER_U_MOVE
      { 'tickodd'=>CIMG['down1'],    'tickeven'=>CIMG['down2'] },	# state == CHASER_D_MOVE
      { 'tickodd'=>CIMG['left1'],    'tickeven'=>CIMG['left2'] },	# state == CHASER_L_MOVE
      { 'tickodd'=>CIMG['right1'],   'tickeven'=>CIMG['right2'] },	# state == CHASER_R_MOVE
   
      { 'tickodd'=>CIMG['upleft1'],  'tickeven'=>CIMG['upleft2'] },	# state == CHASER_UL_MOVE
      { 'tickodd'=>CIMG['upright1'], 'tickeven'=>CIMG['upright2'] },	# state == CHASER_UR_MOVE
      { 'tickodd'=>CIMG['dwleft1'],  'tickeven'=>CIMG['dwleft2'] },	# state == CHASER_DL_MOVE
      { 'tickodd'=>CIMG['dwright1'], 'tickeven'=>CIMG['dwright2'] },	# state == CHASER_DR_MOVE

      { 'tickodd'=>CIMG['utogi1'],   'tickeven'=>CIMG['utogi2'] },	# state == CHASER_U_TOGI
      { 'tickodd'=>CIMG['dtogi1'],   'tickeven'=>CIMG['dtogi2'] },	# state == CHASER_D_TOGI
      { 'tickodd'=>CIMG['ltogi1'],   'tickeven'=>CIMG['ltogi2'] },	# state == CHASER_L_TOGI
      { 'tickodd'=>CIMG['rtogi1'],   'tickeven'=>CIMG['rtogi2'] }	# state == CHASER_R_TOGI
    ]

    setStyleSheet "QWidget { background-color: #008000 }"

    @timer = Qt::BasicTimer.new
    @timer.start((1.0/FRAMESPERSECOND)*1000, self)

    setup # setup chasers
  end

  def setup
    for i in (1..NUMCHASER)
      chaser=Chaser.new(0,0,(@field_width-BITMAP_WIDTH),(@field_height-BITMAP_HEIGHT))
      @chasers.push(chaser);
    end

    # run the chasers through a few interation to put them in a "random" spots.
    for i in (1..50)
      update
    end
  end

  def update
    @chasers.each {|c| c.think}
  end

  def paintEvent event
    painter = Qt::Painter.new
    painter.begin self
    @chasers.each {|c|
      cimg=nil
      if ( not(c.state == CHASER_SLEEP) )
        cimg=(((c.tickcount % 2) == 0 ) ?
              @animationpattern[c.state]['tickeven'] :
              @animationpattern[c.state]['tickodd'] )
      else
        cimg=(((c.tickcount % 8) <= 3) ?
              @animationpattern[c.state]['tickeven'] :
              @animationpattern[c.state]['tickodd'] )
      end

      painter.drawImage c.x, c.y, cimg
    }
    painter.end
  end

  def timerEvent event
    if ! @quit
      update
      repaint
    else
      @timer.stop
      $qApp.quit
    end
  end

  def keyPressEvent event
    key = event.key
    if key == Qt::Key_Q.value
      @quit = true
    end
  end

end

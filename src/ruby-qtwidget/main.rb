require 'Qt'
require 'Grass'

SCREEN_WIDTH=(640)
SCREEN_HEIGHT=(320)

class QtApp < Qt::MainWindow
  def initialize
    super

    setWindowTitle "Chaser"
    setCentralWidget Grass.new(self, SCREEN_WIDTH, SCREEN_HEIGHT)
    resize SCREEN_WIDTH, SCREEN_HEIGHT

    show
  end
end

app = Qt::Application.new ARGV
QtApp.new

app.exec

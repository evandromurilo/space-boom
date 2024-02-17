require 'gosu'

class SpaceBoom < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Boom"
  end
end

window = SpaceBoom.new
window.show

require 'gosu'
require_relative 'player'

class SpaceBoom < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Boom"
    @player = Player.new(self)
  end

  def update
    if button_down?(Gosu::MsLeft)
      @player.accelerate
    else
      @player.friction
    end
    
    @player.move
  end

  def draw
    @player.draw
  end
end

window = SpaceBoom.new
window.show

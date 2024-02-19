require 'gosu'
require_relative 'player'
require_relative 'laser'
require_relative 'ufo'

class SpaceBoom < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Boom"
    @player = Player.new(self)
    @lasers = []
    @enemies = [Ufo.new(self)]
    @laser_sound = Gosu::Sample.new('sounds/laser1.ogg')
  end

  def update
    if button_down?(Gosu::MsLeft)
      @player.accelerate
    else
      @player.friction
    end
    
    @player.move


    @lasers.dup.each do |laser|
      @lasers.delete laser if laser.out_of_screen?
      print "out" if laser.out_of_screen?
    end
    
    @lasers.each do |laser|
      laser.move
    end

    @enemies.each do |enemy|
      enemy.move
    end
  end

  def draw
    @player.draw
    @lasers.each do |laser|
      laser.draw
    end
    @enemies.each do |enemy|
      enemy.draw
    end
  end

  def button_down(id)
    shoot if id == Gosu::MsRight
  end

  def shoot
    @lasers.push(Laser.new(self, @player.x, @player.y, @player.angle))
    @laser_sound.play
  end

  def width
    WIDTH
  end

  def height
    HEIGHT
  end
end

window = SpaceBoom.new
window.show

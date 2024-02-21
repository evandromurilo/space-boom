require 'gosu'
require_relative 'player'
require_relative 'laser'
require_relative 'ufo'

class SpaceBoom < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.01

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Boom"
    @player = Player.new(self)
    @lasers = []
    @enemies = []
    @laser_sound = Gosu::Sample.new('sounds/laser1.ogg')
    @explosion_sound = Gosu::Sample.new('sounds/explosion.wav')
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

      @enemies.each do |enemy|
        if enemy.collide?(laser)
          @lasers.delete laser
          enemy.hit
        end
      end
    end

    @enemies.dup.each do |enemy|
      if enemy.dead?
        @enemies.delete enemy
        @explosion_sound.play
      end
    end
    
    @lasers.each do |laser|
      laser.move
    end

    if not @player.invunerable?
      @enemies.each do |enemy|
        if enemy.collide? @player
          @player.hit
          @explosion_sound.play
        end
      end
    end

    @enemies.each do |enemy|
      enemy.move
    end

    if rand < ENEMY_FREQUENCY
      @enemies.push Ufo.new(self)
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

class Ufo
  SPEED = 2
  
  def initialize(window)
    @window = window
    @radius = 45
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @dir = 1
    @image = Gosu::Image.new('images/ufo_blue.png')
    @hit_sound = Gosu::Sample.new('sounds/laser3.mp3')
    @hit_time = 0
    @life = 5
  end

  def draw
    if @hit_time > Gosu::milliseconds
      @image.draw(@x - @radius, @y - @radius, 0, 1, 1, 0xFFFF0000)
    else
      @image.draw(@x - @radius, @y - @radius)
    end
  end

  def move
    @y += SPEED * @dir
    @dir *= -1 if out_of_screen?
  end

  def collide?(who)
    distance = Gosu.distance(@x, @y, who.x, who.y)
    distance < @radius + who.radius
  end

  def hit
    @hit_sound.play
    @hit_time = Gosu::milliseconds + 300
    @life -= 1
  end

  def dead?
    @life <= 0
  end

  def out_of_screen?
    @x+@radius < 0 or
      @x-@radius > @window.width or
      @y+@radius < 0 or
      @y-@radius > @window.height
  end
end

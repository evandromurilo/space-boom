class Ufo
  SPEED = 2
  
  def initialize(window)
    @window = window
    @radius = 45
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @dir = 1
    @image = Gosu::Image.new('images/ufo_blue.png')
  end

  def draw
    @image.draw(@x - @radius, @y - @radius)
  end

  def move
    @y += SPEED * @dir
    @dir *= -1 if out_of_screen?
  end

  def out_of_screen?
    @x+@radius < 0 or
      @x-@radius > @window.width or
      @y+@radius < 0 or
      @y-@radius > @window.height
  end
end

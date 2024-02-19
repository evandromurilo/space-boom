class Laser
  SPEED = 8
  SIZE = 57
  
  def initialize(window, x, y, angle)
    @window = window
    @x = x
    @y = y
    @angle = angle
    @image = Gosu::Image.new('images/laser_blue.png')
  end

  def move
    @x += Gosu::offset_x(@angle, SPEED)
    @y += Gosu::offset_y(@angle, SPEED)
  end

  def draw
    @image.draw_rot(@x, @y, 0, @angle)
  end

  def out_of_screen?
    @x + SIZE < 0 or
      @x - SIZE > @window.width or
      @y + SIZE < 0 or
      @y - SIZE > @window.height
  end
end

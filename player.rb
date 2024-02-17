class Player
  ACCELERATION = 0.2
  MAX_SPEED = 12
  FRICTION = 0.98
  
  def initialize(window)
    @window = window
    @image = Gosu::Image.new('images/blue_ship.png')
    @x = 200
    @y = 200
    @speed_x = 0
    @speed_y = 0
    @momentum = 0
  end

  def angle
    Gosu::angle(@x, @y, @window.mouse_x, @window.mouse_y)
  end
  
  def accelerate
    @speed_x += ACCELERATION
    @speed_y += ACCELERATION
    @momentum = angle

    @speed_x = MAX_SPEED if @speed_x > MAX_SPEED
    @speed_y = MAX_SPEED if @speed_y > MAX_SPEED
  end
  
  def move
    @x += Gosu::offset_x(@momentum, @speed_x)
    @y += Gosu::offset_y(@momentum, @speed_y)
  end

  def friction
    @speed_x *= FRICTION
    @speed_y *= FRICTION
  end

  def draw
    @image.draw_rot(@x, @y, 1, angle)
  end
end

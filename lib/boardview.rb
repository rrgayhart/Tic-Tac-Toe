

class BoardView
  attr_reader :app, :board

  def initialize(app, board)
    @app = app
    @board = board
  end

  def check_box_state(number)
    board.spaces[number]
  end

  def redraw_markers
    board.space.each do |space, value|
      space = space_nums[space.to_s]
      if value % 2 == 1
        draw_marker('x')
      else
        draw_marker('o')
      end
    end
  end

  def space_nums
    Hash[('a'..'i').zip(1..9)]
  end

  def draw_marker(value, box_num)
    x_cord = get_x_cord(box_num)
    y_cord = get_y_cord(box_num)
    place_value_specific_marker(value, x_cord, y_cord)
  end

  def place_value_specific_marker(value, x_cord, y_cord)
    circle_diameter = 30
    x_size = 15
    if letter.downcase == 'x'
      app.fill 0,20
      app.line(x_cord-x_size,y_cord-x_size,x_cord+x_size,y_cord+x_size)

      app.fill 0,20
      app.line(x_cord-x_size,y_cord+x_size,x_cord+x_size,y_cord-x_size)
    elsif letter.downcase == 'o' #redundant
      app.fill 10,0
      app.ellipse(x_cord,y_cord,circle_diameter,circle_diameter)
    end
  end

  def get_y_cord(number)
    first_row = [1,2,3]
    middle_row = [4,5,6]

    if first_row.include?(number)
      33
    elsif middle_row.include?(number)
      100
    else
      166
    end
  end

  def get_x_cord(number)
    left_column = [1,4,7]
    center_column = [2,5,8]

    if left_column.include?(number)
      33
    elsif center_column.include?(number)
      100
    else
      166
    end
  end

  def draw
    #redraw_markers
    #print out the board layout
    #REDRAW THE BOARD this is what it's look like method
    place_mark_in_box(1,'x')
    #print out the present markers
    #print out victor if any
    true
  end

  def place_mark_in_box(number, letter)
    #unless check_box_state(number).nil?
   #   warn "Pick a different box! That one is taken."
      #raise 'Hell'
    #else
      first_row = [1, 2, 3]
      middle_row = [4,5,6]

      if first_row.include?(number)
        y_coord = 33
      elsif middle_row.include?(number)
        y_coord = 100
      else
        y_coord = 166
      end

      left_column = [1,4,7]
      center_column = [2,5,8]

      if left_column.include?(number)
        x_coord = 33
      elsif center_column.include?(number)
        x_coord = 100
      else
        x_coord = 166
      end

      circle_diameter = 30
      x_size = 15
      if letter.downcase == 'x'
        app.fill 0,20
        app.line(x_coord-x_size,y_coord-x_size,x_coord+x_size,y_coord+x_size)

        app.fill 0,20
        app.line(x_coord-x_size,y_coord+x_size,x_coord+x_size,y_coord-x_size)
      elsif letter.downcase == 'o' #redundant
        app.fill 10,0
        app.ellipse(x_coord,y_coord,circle_diameter,circle_diameter)
      end
    #end
    #@board_state[number] = letter.to_sym
  end

end

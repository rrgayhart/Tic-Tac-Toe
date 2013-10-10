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
    board.spaces.each do |space, value|
      box = space_nums[space.to_s]
      unless value.nil?
        if value % 2 == 1
          draw_marker('x', box)
        else
          draw_marker('o', box)
        end
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
    if value.downcase == 'x'
      app.fill 0,20
      app.line(x_cord-x_size,y_cord-x_size,x_cord+x_size,y_cord+x_size)

      app.fill 0,20
      app.line(x_cord-x_size,y_cord+x_size,x_cord+x_size,y_cord-x_size)
    elsif value.downcase == 'o' #redundant
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
    app.background(100,100,100)
    check_for_dead_game
    check_for_winner
    redraw_board
    redraw_markers
    draw_winning_line if app.board.winning_combination_present?
  end

  def check_for_dead_game
    if board.full? && !board.winning_combination_present?
      app.background(255,0,0,100)
    end
  end

  def check_for_winner
    if board.winning_combination_present?
      app.background(0,255,0,0.5)
    end
  end

  def redraw_board
    box = 200
    third = box/3
    app.line(box,third,0,third)
    app.line(box,2*third,0,2*third)
    app.line(third,box,third,0)
    app.line(2*third,box,2*third,0)
  end

  def draw_winning_line
    winner_cords = app.get_coordinates_for_winner
    first = winner_cords[0]
    last = winner_cords[2]
    app.stroke_weight(5)
    app.line(first[0],first[1],last[0],last[1])
  end
end

require 'board'

class BoardView
  attr_reader :app, :board

  def initialize(app, board)
    @app = app
    @board = board
  end

  def check_box_state(number)
    board.spaces[number]
  end

  def draw
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

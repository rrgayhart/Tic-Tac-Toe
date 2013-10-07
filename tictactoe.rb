require 'ruby-processing'

class TicTacToe < Processing::App

  def setup
    box = 200
    third = box/3
    line(box,third,0,third)
    line(box,2*third,0,2*third)
    line(third,box,third,0)
    line(2*third,box,2*third,0)
  end

  def draw
  end

  def key_pressed
    warn " A key was pressed: #{key.inspect}"
    @queue ||= ""
    if key != "\n"
      @queue += key
    else
      if @queue =~ /(X|O)\d/i
        run_command(@queue)
      else
        warn "The command should be an X or an O followed by 1-9."
      end
      @queue = ""
    end
  end

  def run_command(input)
    number = input[-1]
    letter = input[0]
    place_mark_in_box(number.chr.to_i, letter)
    warn "You made a play"
  end

  def place_mark_in_box(number, letter)
    # figure out, x, y coordinates of where to put the shapes
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
    if letter == 120
      fill 0,20
      line(x_coord-x_size,y_coord-x_size,x_coord+x_size,y_coord+x_size)
      
      fill 0,20
      line(x_coord-x_size,y_coord+x_size,x_coord+x_size,y_coord-x_size)
    elsif letter == 111 #redundant
      fill 10,0
      ellipse(x_coord,y_coord,circle_diameter,circle_diameter)
    end
  end

  box = 200
  TicTacToe.new(:width => box, :height => box, :full_screen => false)

end

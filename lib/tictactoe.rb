require 'ruby-processing'
require 'board'

class TicTacToe < Processing::App

  def setup
    board_validation_setup
    box = 200
    third = box/3
    line(box,third,0,third)
    line(box,2*third,0,2*third)
    line(third,box,third,0)
    line(2*third,box,2*third,0)
  end

  def draw
  end

  def board_validation_setup
    max_board_size = 9
    # (1..max_board_size)
    @board_state = Hash.new
    [1,2,3,4,5,6,7,8,9].each do |box|
      @board_state[box] = :empty
    end
    # @board_state = Hash.new {|h,k| }
    # @board_state.default(:empty)
  end

  def board_state
    @board_state
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
    letter = input[0].chr
    place_mark_in_box(number.chr.to_i, letter)
    warn "You made a play"
  end

  def check_box_state(number)
    @board_state[number]
  end

  def place_mark_in_box(number, letter)
    unless check_box_state(number) == :empty
      warn "Pick a different box! That one is taken."
    else
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
        fill 0,20
        line(x_coord-x_size,y_coord-x_size,x_coord+x_size,y_coord+x_size)

        fill 0,20
        line(x_coord-x_size,y_coord+x_size,x_coord+x_size,y_coord-x_size)
      elsif letter.downcase == 'o' #redundant
        fill 10,0
        ellipse(x_coord,y_coord,circle_diameter,circle_diameter)
      end
    end
    @board_state[number] = letter.to_sym
  end

  box = 200
  TicTacToe.new(:width => box, :height => box, :full_screen => false)

end


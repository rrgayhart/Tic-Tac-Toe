require 'ruby-processing'
require 'board'
require 'boardview'

class TicTacToe < Processing::App

  attr_reader :board_view, :board, :box, :box_dimension

  def setup
    @board = Board.new
    @board_view = BoardView.new(self, @board)
    @box = 200
    @box_dimension = 3
  end

  def draw
    board_view.draw
  end

  def mouse_pressed
    box_num = determine_box(mouse_x, mouse_y)
    @player_marker ||= 'x'
    letter_mapping = (@player_marker == 'x' ? 1 : 0)
    placement_mapping = {1 => :a, 2 => :b, 3 => :c, 4 => :d, 5 => :e, 6 => :f, 7 => :g, 8 => :h, 9 => :i}
    board.move(placement_mapping[box_num], letter_mapping)
    @player_marker = @player_marker == 'o' ? 'x' : 'o'
  end

  def determine_column_or_row(position)
    single_box_width = @box / @box_dimension
    if position < single_box_width
      1
    elsif position < 2 * single_box_width
      2
    else
      3
    end
  end

  def determine_box(x, y)
    column = determine_column_or_row(x)
    row = determine_column_or_row(y)
    if row == 1
      column * row
    else
      (column * row) + (row-1)*(box_dimension - column)
    end
  end

  def key_pressed
    warn " A key was pressed: #{key.inspect}"
    @queue ||= ""
    if key != "\n"
      @queue += key
    elsif @queue =~ /(X|O)\d/i
      run_command(@queue)
      @queue = ""
    elsif @queue == "reset"
      reset_board
      @queue = ""
    else
        warn "The command should be an X or an O followed by 1-9. Or, if you're annoyed
        type 'reset' followed by return to reset the board."
    @queue = ""
    end
  end

  def reset_board
    board.reset
    puts board.spaces
  end

  def run_command(input)
    letter = input[0].chr.downcase
    number = input[-1].chr.to_i
    placement_mapping = {1 => :a, 2 => :b, 3 => :c, 4 => :d, 5 => :e, 6 => :f, 7 => :g, 8 => :h, 9 => :i}
    letter_mapping = (letter == 'x' ? 1 : 0)
    board.move(placement_mapping[number], letter_mapping)
    warn "You made a play"
  end

  box = 200
  TicTacToe.new(:width => box, :height => box, :full_screen => false)

end


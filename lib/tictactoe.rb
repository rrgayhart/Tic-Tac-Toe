require 'ruby-processing'
require 'board'
require 'boardview'

class TicTacToe < Processing::App

  attr_reader :board_view, :board

  def setup
    @board = Board.new
    @board_view = BoardView.new(self, @board)
  end

  def draw
    board_view.draw
  end

  def key_pressed
    warn " A key was pressed: #{key.inspect}"
    @queue ||= ""
    if key != "\n"
      @queue += key
    elsif @queue =~ /(X|O)\d/i
        run_command(@queue)
    elsif @queue == "reset"
      reset_board
    else
        warn "The command should be an X or an O followed by 1-9. Or, if you're annoyed
        type 'reset' followed by return to reset the board."
    @queue = ""
    end
  end

  def reset_board
    board.reset
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


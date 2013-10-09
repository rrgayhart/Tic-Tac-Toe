require 'ruby-processing'
require 'board'
require 'boardview'

class TicTacToe < Processing::App

  attr_reader :board_view, :board

  def setup
    box = 200
    third = box/3
    line(box,third,0,third)
    line(box,2*third,0,2*third)
    line(third,box,third,0)
    line(2*third,box,2*third,0)
    @board = Board.new
    @board_view = BoardView.new(self, @board)
  end

  def draw
    board_view.draw
  end

  # def board_validation_setup
  #   max_board_size = 9
  #   # (1..max_board_size)
  #   @board_state = Hash.new
  #   [1,2,3,4,5,6,7,8,9].each do |box|
  #     @board_state[box] = :empty
  #   end
  #   # @board_state = Hash.new {|h,k| }
  #   # @board_state.default(:empty)
  # end

  # def board_state
  #   @board_state
  # end

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


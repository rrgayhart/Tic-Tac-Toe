require 'ruby-processing'
require 'board'
require 'boardview'

class TicTacToe < Processing::App

  attr_reader :board_view

  def setup
    box = 200
    third = box/3
    line(box,third,0,third)
    line(box,2*third,0,2*third)
    line(third,box,third,0)
    line(2*third,box,2*third,0)
    @board_view = BoardView.new(self,Board.new)
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
    number = input[-1]
    letter = input[0].chr
    #board_view.place_mark_in_box(number.chr.to_i, letter)
    # UPDATE MODEL
    warn "You made a play"
  end



 

  box = 200
  TicTacToe.new(:width => box, :height => box, :full_screen => false)

end


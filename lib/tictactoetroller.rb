require_relative 'board'

class TicTacToeTroller

  attr_reader :model

  def initialize
    @model = Board.new
  end

  def run_command(input)
    letter = input[0].downcase
    number = input[-1].to_i
    placement_mapping = Hash[(1..9).zip('a'..'i')]
    letter_mapping = (letter == 'x' ? 1 : 0)
    model.spaces[placement_mapping[number].to_sym] = letter_mapping
  end
end

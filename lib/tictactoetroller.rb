require_relative 'board'

class TicTacToeTroller

  attr_reader :model

  def initialize
    @model = Board.new
  end
end

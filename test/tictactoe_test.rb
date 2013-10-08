require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class TicTacToeTest < MiniTest::Test

  def test_model_created_when_tictactoe_initialized
    ttt = TicTacToeTroller.new
    assert_kind_of Board, ttt.model
  end
end

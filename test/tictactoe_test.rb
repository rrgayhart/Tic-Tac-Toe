require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tictactoe'

class TicTacToeTest < MiniTest::Test

  def test_model_created_when_tictactoe_initialized
    ttt = TicTacToe.new
    assert_kind_of Board, ttt.model
  end
end

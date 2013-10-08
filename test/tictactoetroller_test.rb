require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/tictactoetroller'

class TicTacToeTest < MiniTest::Test

  attr_reader :ttt

  def setup
    @ttt = TicTacToeTroller.new
  end

  def test_model_created_when_tictactoe_initialized
    assert_kind_of Board, ttt.model
  end

  def test_run_command_updates_model_correctly
    ttt.run_command('x1')
    assert_equal 1, ttt.model.spaces[:a]
    ttt.run_command('o2')
    assert_equal 0, ttt.model.spaces[:b]
  end

  #def test_run_command_will_
end

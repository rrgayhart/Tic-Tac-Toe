require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/boardview'
require_relative '../lib/board'

class BoardViewTest < MiniTest::Test

  attr_reader :board, :app, :board_view

  def setup
    @board = Board.new
    @app = TestApp.new
    @board_view = BoardView.new(app, board)
  end

  def test_it_should_return_app_object
    assert_kind_of TestApp, board_view.app
    assert_kind_of Board, board_view.board
  end

  def test_calling_board_on_boardview_returns_hash
    assert_kind_of Hash, board_view.board.spaces
  end

end

class TestApp


  def method_missing(name, params)

  end
end

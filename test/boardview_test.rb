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

  def test_boardview_responds_to_draw
    assert_respond_to board_view, :draw
  end

  def test_no_error_when_draw_called
    assert board_view.draw
  end

  # def test_method_draw_calls_redraw_markers
  #   board_view.draw
  #   assert_send([board_view, :redraw_markers])
  # end

end

class TestApp


  def method_missing(name, *params)

  end
end

require 'ruby-processing'
require './board'
require './boardview'
require 'httparty'
require 'json'
class TicTacToe < Processing::App

  attr_reader :board_view, :board, :box, :box_dimension

  def setup
    @board = Board.new
    @board_view = BoardView.new(self, @board)
    @box = 200
    @box_dimension = 3
    #@thread = Thread.new do
    #  while true do
    #    puts "checking for move, fool"
    #    sleep 5
    #  end
    #end
    @game_id = create_game
    puts "game id is #{game_id}"
    joined_status = join_game(game_id)
    puts "after joining"
    puts "Game #{game_id} joined" if joined_status
  end

  attr_reader :game_id

  def create_game
    response = HTTParty.post("http://safe-brook-1547.herokuapp.com/games", { :query => {:player_one => "Thomas"}})
    data = JSON.parse(response.body)
    data["id"]
  end

  def join_game(game_id)
    response = HTTParty.put("http://safe-brook-1547.herokuapp.com/games/#{game_id}", { :query => {:player_two => "Engine"}})
    data = JSON.parse(response.body)
    data["joined"]
  end

  # def draw_winning_line(fx,fy,lx,ly)
  #   stroke_weight(5)
  #   line(fx,fy,lx,ly)
  # end

  def draw
    board_view.draw
  end

  def mouse_pressed
    box_num = determine_box(mouse_x, mouse_y)
    @player_marker ||= 'x'
    letter_mapping = (@player_marker == 'x' ? 1 : 0)
    placement_mapping = {1 => :a, 2 => :b, 3 => :c, 4 => :d, 5 => :e, 6 => :f, 7 => :g, 8 => :h, 9 => :i}
    box_num_state = board.spaces[placement_mapping[box_num]].nil?

    row_col = create_row_col_from_box_num(box_num)
    row = row_col[1]
    col = row_col[0]
    web_board_position = "#{col},#{row},#{@player_marker}"

    HTTParty.post("http://safe-brook-1547.herokuapp.com/games/#{game_id}/moves", { :query => { :data => web_board_position } })
    #board.move(placement_mapping[box_num], letter_mapping) unless board.expired?
    response = HTTParty.get("http://safe-brook-1547.herokuapp.com/games/#{game_id}/moves/last")
    puts "last move is #{response}"
    data = JSON.parse(response.body)["move"]
    x,y,letter = data.split(",")
    puts "x is #{x}"
    puts "y is #{y}"
    web_letter_mapping = (letter == 'x' ? 1 : 0)
    web_box_number = determine_box(x.to_i,y.to_i)
    puts "web_letter is #{web_letter_mapping}"
    puts "web_box is #{web_box_number}"
    board.move(placement_mapping[web_box_number], web_letter_mapping)
    if box_num_state
      @player_marker = @player_marker == 'o' ? 'x' : 'o'
    end
  end

  def create_row_col_from_box_num(box_num)
    row = (box_num/box_dimension.to_f).ceil
    column = box_num%box_dimension == 0 ? box_dimension : box_num%box_dimension
    [column, row]
  end

  def determine_column_or_row(position)
    single_box_width = @box / @box_dimension
    if position < single_box_width
      1
    elsif position < 2 * single_box_width
      2
    else
      3
    end
  end

  def determine_box(x, y)
    column = determine_column_or_row(x)
    row = determine_column_or_row(y)
    if row == 1
      column * row
    else
      (column * row) + (row-1)*(box_dimension - column)
    end
  end

  def get_x_y_cords_for_box(box_num)
    row = (box_num/box_dimension.to_f).ceil
    column = box_num%box_dimension == 0 ? box_dimension : box_num%box_dimension
    [coordinate(column), coordinate(row)]
  end

  def coordinate(row_or_col)
    row_or_col*(box/box_dimension)-(box/(box_dimension*2))
  end

  def get_box_nums_for_winner
    convert_board_letters(board.winning_set)
  end

  def get_coordinates_for_winner
    get_box_nums_for_winner.map do |box_num|
      get_x_y_cords_for_box(box_num)
    end
  end

  def convert_board_letters(letters_array)
    mapping = {:a=>1,:b=>2,:c=>3,:d=>4,:e=>5,:f=>6,:g=>7,:h=>8,:i=>9}
    letters_array.map do |sym_letter|
      mapping[sym_letter]
    end
  end

  def key_pressed
    warn " A key was pressed: #{key.inspect}"
    @queue ||= ""

    if key != "\n"
      @queue += key.inspect.gsub('"',"")
    elsif @queue =~ /(X|O)\d/i
      run_command(@queue)
      @queue = ""
    elsif @queue == "reset"
      reset_board
      @queue = ""
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
    board.move(placement_mapping[number], letter_mapping) unless board.expired?
    warn "You made a play"
  end

  box = 200
  TicTacToe.new(:width => box, :height => box, :full_screen => false)

end


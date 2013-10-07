require 'ruby-processing'

class TicTacToe < Processing::App

  def setup
    box = 200
    third = box/3
    line(box,third,0,third)
    line(box,2*third,0,2*third)
    line(third,box,third,0)
    line(2*third,box,2*third,0)
    #line(x1,y1,x2,y2)
  end

  box = 200
  TicTacToe.new(:width => box, :height => box, :full_screen => false)

end

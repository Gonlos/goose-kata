class Board
  @board : Array(Cells) # Internal representation of the board

  def initialize
    @board = [
      Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::BRIDGE, Cells::GOOSE, Cells::GOOSE, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::GOOSE, Cells::EMPTY,
      Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::GOOSE, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::GOOSE, Cells::EMPTY, Cells::EMPTY,
      Cells::EMPTY, Cells::EMPTY, Cells::GOOSE, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::GOOSE, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY,
      Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY,
      Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY,
      Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY, Cells::EMPTY,
      Cells::EMPTY, Cells::EMPTY, Cells::WIN,
    ]
  end

  def at(position : Int32) : Cells
    @board[position]
  end

  def set(position : Int32, content : Cells)
    @board[position] = content
  end

  def to_s
    s = ""
    @board.map_with_index do |cell, index|
      if index % 10 == 0
        print '\n'
      end

      print case cell
      when Cells::EMPTY
        ". "
      when Cells::GOOSE
        "G "
      when Cells::WIN
        "W "
      when Cells::BRIDGE
        "B "
      when Cells::PLAYER
        "P "
      end
    end

    s
  end
end

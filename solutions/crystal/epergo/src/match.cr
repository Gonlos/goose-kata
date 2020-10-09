class Match
  @board : Board
  getter players : Array(Player)

  def initialize
    @players = [] of Player
    @board = Board.new
  end

  def add_player(name : String) : Bool
    return false if players.any? { |player| player.name == name }

    players << Player.new(name)

    true
  end

  def move_player(playername : String, dice : Int32) : Array(Int32)
    player = @players.find { |player| player.name == playername }.not_nil!
    previous_position = player.position
    player.position += dice - 1
    @board.set(player.position, Cells::PLAYER)

    [previous_position, player.position]
  end

  def winner? : Player | Nil
    return unless @board.at(63) != Cells::WIN

    @players.find { |player| player.position == 63 }
  end

  def status : String
    s = ""
    @players.each do |player|
      position_label = player.position == 0 ? "START" : player.position
      s += "#{player.name} at #{position_label}"
      s += '\n'
    end

    s += @board.to_s

    s
  end
end

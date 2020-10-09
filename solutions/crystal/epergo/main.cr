class Player
  property name : String
  property position : Int32

  def initialize(@name)
    @position = 0
  end
end

enum Cells
  EMPTY
  GOOSE
  BRIDGE
  WIN
  PLAYER
end

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

class Game
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

    @players.find { |player| player.position == 63}
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

game = Game.new
playing = true

while playing
  print "> "
  user_input = gets

  if user_input
    tokens = user_input.split(" ")
    command = tokens.shift
    case command
    when "exit"
      playing = false
    when "add"
      # Next token must be `player`
      token = tokens.shift
      if token != "player"
        puts "couldn't add the player, invalid syntax `ie: add player your_username`"
        next
      end

      player_name = tokens.shift
      if player_name.blank?
        puts "couldn't add the player, missing player name"
        next
      end

      if game.add_player(player_name)
        puts "players: #{game.players.map(&.name).join(", ")}"
      else
        puts "#{player_name}: already existing player"
      end
    when "move"
      player = tokens.shift
      dice1, dice2 = tokens.first.split(",")
      prev, current = game.move_player(player, dice1.to_i + dice2.to_i)

      message = "#{player} rolls #{dice1}, #{dice2}. #{player} moves from #{prev} to #{current}"

      winner = game.winner?
      if winner && winner.name == player
        message += " #{player} Wins!!"
      end

      puts " \n#{game.status} \n"

      puts message
    else
    end
  end
end

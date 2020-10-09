require "./match.cr"
require "./cells.cr"
require "./board.cr"
require "./player.cr"

class Game
  def play
    game = Match.new
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
  end
end

Game.new.play

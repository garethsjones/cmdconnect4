require 'highline/import'

require_relative 'Board'
require_relative 'Player'

class TwoPlayerGame
  
  def main
    
    board = Board.new
    
    player_1_name = ask("Player 1 name (O): ")
    player_1 = Player.new(player_1_name, Counter::RED)
    
    
    player_2_name = ask("Player 2 name (X): ")
    player_2 = Player.new(player_2_name, Counter::YELLOW)
    
    puts "\n" + board.to_s
    
    for turn in 1..21
      
      if take_turn(player_1, board)
        return
      end
      
      if take_turn(player_2, board)
        return
      end
      
    end
    
    puts "Drawn game!! :("
    
  end
  
  def take_turn(player, board)
    column = ask("#{player.name}'s turn: ", Integer) { |q| q.in = 0..6 }
      
      result = board.play(column, player.colour)
      
      puts "\n" + board.to_s
      
      if result
        puts "#{player.name} is the winner!!"
        return true
      end
  end
  
  game = self.new
  game.main
  
end


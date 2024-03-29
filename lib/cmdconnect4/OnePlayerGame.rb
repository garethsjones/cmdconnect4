require 'highline/import'

require_relative 'Board'
require_relative 'Player'
require_relative 'TreeHuggingOpponent'

class OnePlayerGame
  
  def main
    
    board = Board.new
    
    player_1_name = ask("Player 1 name (O): ")
    player_1 = Player.new(player_1_name, Counter::RED)
    
    
    cpu_name = ask("CPU name (X): ")
    opponent = TreeHuggingOpponent.new(board, Counter::YELLOW)
    
    coin_toss = rand(0..1)
    
    if coin_toss == 0
      puts "#{cpu_name} will go first"
    else
      puts "#{player_1_name} will go first"
    end
    
    puts "\n" + board.to_s
    
    for turn in 1..((Board::HEIGHT * Board::WIDTH) / 2)
      
      if (coin_toss == 0)
        if opponent_turn(cpu_name, opponent, board)
          return
        end
      end
      
      if take_turn(player_1, opponent, board)
        return
      end
      
      if (coin_toss == 1)
        if opponent_turn(cpu_name, opponent, board)
          return
        end
      end
      
    end
    
    puts "Drawn game!! :("
  end
  
  def take_turn(player, opponent, board)
    column = ask("#{player.name}'s turn: ", Integer) { |q| q.in = 0..6 }
    result = board.play(column, player.colour)
    puts "\n" + board.to_s
    
    if result
      puts "#{player.name} is the winner!!"
      return true
    end
    
    opponent.my_move column
    return false
  end
  
  def opponent_turn(cpu_name, opponent, board)
    column = opponent.next_move
    puts "#{cpu_name}'s turn: #{column}"
    result = board.play(column, Counter::YELLOW)
    puts "\n" + board.to_s
    
    if result
      puts "#{cpu_name} is the winner!!"
      return true
    end
    
    return false
  end
  
  game = self.new
  game.main
  
end


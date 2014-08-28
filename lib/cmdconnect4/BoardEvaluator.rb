require_relative 'Board'
require_relative 'LetterBox'

class BoardEvaluator
  
  def initialize(board, colour)
    @board = board
    @colour = colour
  end
  
  def evaluate
    @letter_box = LetterBox.new(@colour)
    score = 0
    score += evaluate_vertical
    score += evaluate_horizontal
    score += evaluate_diagonal_up
    score += evaluate_diagonal_down
    #puts score
    return score
  end
  
  def evaluate_vertical
    score = 0
    for x in 0..(Board::WIDTH - 1)
      @letter_box.reset
      for y in 0..(Board::HEIGHT - 1)
        #puts "#{x},#{y}"
        score += @letter_box.next(@board.get(x, y))
      end
    end
    return score
  end
  
  def evaluate_horizontal
    score = 0
    for y in 0..(Board::HEIGHT - 1)
      @letter_box.reset
      for x in 0..(Board::WIDTH - 1)
        #puts "#{x},#{y}"
        score += @letter_box.next(@board.get(x, y))
      end
    end
    return score
  end
  
  def evaluate_diagonal_up
    score = 0
    start_y = Board::HEIGHT - 1
    while (true)
      @letter_box.reset
      touched_board = false
      
      for x in 0..(Board::WIDTH - 1)
        y = start_y + x
        if y >= 0 and y < Board::HEIGHT
          #puts "#{x},#{y}"
          touched_board = true
          score += @letter_box.next(@board.get(x, y))
        end
      end
      
      if touched_board
        start_y -= 1
      else
        return score
      end
    end
  end
  
  def evaluate_diagonal_down
    score = 0
    start_y = 0
    while (true)
      @letter_box.reset
      touched_board = false
      
      (Board::WIDTH - 1).downto(0) do |x|
        y = start_y - x
        if y >= 0 and y < Board::HEIGHT
          #puts "#{x},#{y}"
          touched_board = true
          score += @letter_box.next(@board.get(x, y))
        end
      end
      
      if touched_board
        start_y += 1
      else
        return score
      end
    end
  end
  
end
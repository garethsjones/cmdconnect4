require_relative 'Board'
require_relative 'Counter'

class LetterBox
  
  MULTIPLIER = Board::WIDTH * Board::HEIGHT * Board::TO_WIN
  
  def initialize(our_colour)
    @our_colour = our_colour
    reset
  end
  
  def reset
    @holes = Array.new(Board::TO_WIN)
    @counter = 0
  end
  
  def next(colour)
    slot = @counter % Board::TO_WIN
    @holes[slot] = colour
    @counter += 1
    if @counter >= Board::TO_WIN
      return score
    end
    return 0
  end
  
  def score
    ours = 0
    theirs = 0
    @holes.each do |colour|
      if colour == @our_colour
        ours += 1
      elsif colour != nil
        theirs += 1
      end
    end
    
    #puts "#{ours} of ours, #{theirs} of theirs"
      
    if (ours > 0 and theirs == 0)
      return weight(ours)
    end
    
    if (theirs > 0 and ours == 0)
      return -(weight(theirs))
    end
    
    return 0
  end
  
  def weight(number_of_counters)
    n = 1
    score = 1
    
    while (n < number_of_counters)
      n += 1
      score *= (MULTIPLIER)
    end
    
    return score
  end
  
end

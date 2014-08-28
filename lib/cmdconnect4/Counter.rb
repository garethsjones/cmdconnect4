class Counter
  
  RED = 0
  YELLOW = 1
  
  def self.other(colour)
    if colour == RED
      return YELLOW
    elsif colour == YELLOW
      return RED
    else
      raise "Unknown colour #{colour}"
    end
  end
  
end
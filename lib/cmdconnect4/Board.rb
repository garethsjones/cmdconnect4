require_relative 'Counter'

class Board
  
  WIDTH = 7
  HEIGHT = 6
  TO_WIN = 4
  
  def initialize
    @columns = Array.new(WIDTH)
    
    for index in 0..(WIDTH - 1)
      @columns[index] = Array.new(HEIGHT)
    end
  end
  
  def fill(columns)
    @columns = columns
  end
  
  def clone
    columns_clone = Array.new(WIDTH - 1)
    
    for x in 0..(@columns.length - 1)
      columns_clone[x] = Array.new(HEIGHT)
      for y in 0..(HEIGHT - 1)
        columns_clone[x][y] = @columns[x][y]
      end
    end
    
    clone = Board.new
    clone.fill columns_clone
    return clone
  end
  
  def get(x, y)
    if x >= WIDTH || y > HEIGHT
      raise "Position #{x},#{y} is out of range"
    end
    return @columns[x][y]
  end
  
  def set(x, colour)
    if (x < 0 or x >= WIDTH)
      raise "Column must be between 0 and #{WIDTH}"
    end
    
    for y in 0..(HEIGHT - 1)
      if @columns[x][y] == nil
        @columns[x][y] = colour
        return y
      end
    end
    raise "Column #{x} is full"
  end
  
  def play(x, colour)
    y = set(x, colour)
    return ends_game?(x, y, colour)
  end
  
  def ends_game?(x, y, colour)
    #puts "ends game #{x} #{y} #{colour}"
    return ((contiguous_vertical(x, y, colour) >= TO_WIN) or 
      (contiguous_horizontal(x, y, colour) >= TO_WIN) or 
      (contiguous_diagonal_up(x, y, colour) >= TO_WIN) or 
      (contiguous_diagonal_down(x, y, colour) >= TO_WIN)) 
  end
  
  def contiguous_vertical(x, y, colour)
    return 1 + contiguous(x, y, colour, 0, 1) + contiguous(x, y, colour, 0, -1)
  end
  
  def contiguous_horizontal(x, y, colour)
    return 1 + contiguous(x, y, colour, 1, 0) + contiguous(x, y, colour, -1, 0)
  end
  
  def contiguous_diagonal_up(x, y, colour)
    return 1 + contiguous(x, y, colour, 1, 1) + contiguous(x, y, colour, -1, -1)
  end
  
  def contiguous_diagonal_down(x, y, colour)
    return 1 + contiguous(x, y, colour, 1, -1) + contiguous(x, y, colour, -1, 1)
  end
  
  def contiguous(x, y, colour, x_incr, y_incr)
    result = 0
    for n in 1..(TO_WIN - 1)
      test_x = x + (x_incr * n)
      test_y = y + (y_incr * n)
      #puts "#{test_x} #{test_y}"
      if (test_x < 0 or test_y < 0 or test_x > 6 or test_y > 5)
        #puts "OOB #{result}"
        return result
      end
      if (@columns[test_x][test_y] != colour)
        #puts "Wrong colour #{result}"
        return result
      end
      #puts "Match"
      result += 1
    end
    return result
  end
  
  def to_s
    result = ""
    (HEIGHT - 1).downto(0) do |row|
      for col in 0..(WIDTH - 1)
        space = @columns[col][row]
        if space == Counter::RED
          result += "O"
        elsif space == Counter::YELLOW
          result += "X"
        else
          result += "|"
        end
      end
      result += "\n"
    end
    
    for i in 0..(WIDTH - 1)
        result += i.to_s
      end
      result += "\n"
    
    return result
  end
  
end
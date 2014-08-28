class Move
  
  attr_accessor :steps, :value
  attr_reader :colour
  
  def initialize(steps, colour, value)
    @steps = steps
    @colour = colour
    @value = value
  end
  
  def <=> (other)
    other.value <=> @value
  end
  
  def to_s
    "x = #{@steps.last} value = #{@value}"
  end
  
end
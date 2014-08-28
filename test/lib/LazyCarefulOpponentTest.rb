require 'minitest/autorun'

require '../../lib/cmdconnect4/LazyCarefulOpponent'
require '../../lib/cmdconnect4/Board'
require '../../lib/cmdconnect4/Counter'

class LazyCarefulOpponentTest < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new
    @opponent = LazyCarefulOpponent.new(@board, Counter::RED)
  end
  
  def test
    @opponent.next_move
  end
  
end
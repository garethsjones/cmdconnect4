require 'minitest/autorun'

require '../../lib/cmdconnect4/BoardEvaluator'
require '../../lib/cmdconnect4/Board'
require '../../lib/cmdconnect4/Counter'

class BoardEvaluatorTest < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new
    @board_evaluator = BoardEvaluator.new(@board, Counter::YELLOW)
  end
  
  def test
    @board.play(6, Counter::YELLOW)
    assert_equal(3, @board_evaluator.evaluate)
  end
  
end
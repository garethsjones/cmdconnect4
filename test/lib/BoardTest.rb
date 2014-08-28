require 'minitest/autorun'

require '../../lib/cmdconnect4/Board'
require '../../lib/cmdconnect4/Counter'

class BoardTest < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new
  end
  
  def test_to_s
    @board.play(0, Counter::RED)
    @board.play(2, Counter::YELLOW)
    @board.play(5, Counter::RED)
    @board.play(5, Counter::YELLOW)
    @board.play(1, Counter::RED)
    #puts @board.to_s
  end
  
  def test_vertical
    refute @board.play(0, Counter::RED)
    refute @board.play(0, Counter::RED)
    refute @board.play(0, Counter::RED)
    assert @board.play(0, Counter::RED)
  end
  
  def test_horizontal
    refute @board.play(1, Counter::RED)
    refute @board.play(3, Counter::RED)
    refute @board.play(4, Counter::RED)
    assert @board.play(2, Counter::RED)
  end

  def test_diagonal_up
    refute @board.play(1, Counter::RED)
    refute @board.play(2, Counter::YELLOW)
    refute @board.play(3, Counter::YELLOW)
    refute @board.play(4, Counter::YELLOW)
    refute @board.play(2, Counter::RED)
    refute @board.play(3, Counter::YELLOW)
    refute @board.play(4, Counter::YELLOW)
    refute @board.play(3, Counter::RED)
    refute @board.play(4, Counter::YELLOW)
    assert @board.play(4, Counter::RED)
  end
 
  def test_diagonal_down
    refute @board.play(2, Counter::RED)
    refute @board.play(2, Counter::RED)
    refute @board.play(2, Counter::RED)
    refute @board.play(3, Counter::RED)
    refute @board.play(3, Counter::RED)
    refute @board.play(4, Counter::RED)
    refute @board.play(2, Counter::YELLOW)
    refute @board.play(3, Counter::YELLOW)
    refute @board.play(5, Counter::YELLOW)
    assert @board.play(4, Counter::YELLOW)
  end 
  
  def test_invalid_column
    assert_raises(RuntimeError){ @board.play(-1, Counter::RED)}
  end
  
  def test_over_fill
    @board.play(2, Counter::RED)
    @board.play(2, Counter::RED)
    @board.play(2, Counter::RED)
    @board.play(2, Counter::RED)
    @board.play(2, Counter::RED)
    @board.play(2, Counter::RED)
    assert_raises(RuntimeError){ @board.play(2, Counter::RED)}
  end
end
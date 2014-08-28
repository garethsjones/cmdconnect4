require 'minitest/autorun'

require '../../lib/cmdconnect4/LetterBox'
require '../../lib/cmdconnect4/Counter'

class LetterBoxTest < MiniTest::Unit::TestCase
  
  def setup
    @letter_box = LetterBox.new(Counter::RED)
  end
  
  def test_no_score_first_three
    assert_equal(0, @letter_box.next(Counter::RED))
    assert_equal(0, @letter_box.next(nil))
    assert_equal(0, @letter_box.next(nil))
    assert_equal(1, @letter_box.next(nil))
  end
  
  def test_red_nil_nil_red
    assert_equal(0, @letter_box.next(Counter::RED))
    assert_equal(0, @letter_box.next(nil))
    assert_equal(0, @letter_box.next(nil))
    assert_equal(LetterBox::MULTIPLIER, @letter_box.next(Counter::RED))
  end
  
end
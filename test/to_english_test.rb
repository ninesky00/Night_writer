require 'minitest/autorun'
require 'minitest/pride'
require './lib/'

class Test < MiniTest::Test
  def setup
    @english = ToEnglish.new
    @line1 = "0.0.0.0.0."
    @line2 = "00.00.0..0"
    @line3 = "....0.0.0."
  end

  def test_attributes_are_instantiated
    assert_instance_of ToEnglish, @english
  end

  def test_can_convert_braille_lines_to_one
    assert_equal "x", @english.convert_to_read
  end
end
require 'minitest/autorun'
require 'minitest/pride'
require './lib/to_braille'

class ToBrailleTest < MiniTest::Test
  def setup
    @translate = ToBraille.new
    @string_text = "hello"
    @long_string = "hello, this is a long string test so that the test knows to break when lines are too long"
  end

  def test_attributes_are_instantiated
    assert_instance_of ToBraille, @translate
  end

  def test_can_translate_english_to_braille
    expected = ["0.", "00", ".."], ["0.", ".0", ".."], ["0.", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", "0."]
    assert_equal expected, @translate.translate(@string_text)
  end

  def test_can_convert_to_write_braille
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, @translate.convert_to_write(@string_text)
  end

  def test_can_break_new_line_when_output_is_too_long
    # braille_array = @translate.convert_to_write(@long_string)
    expected = "0.0.0.0.0......00..0.0...0.0..0...0.0.0000...0.00..00000...00..0.0...00....00.0\n" +
    "00.00.0..00...00000.0...0.0.......0..0.000..0.00000..000..00.00.00..0..0..0000.\n" +
    "....0.0.0.....0.....0.....0.......0.0.0.....0.0.0...0.....0...0.0...0.0...0...."
    assert_equal expected, @translate.limit_to_80_characters(@long_string)
  end
end
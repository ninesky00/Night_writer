require 'minitest/autorun'
require 'minitest/pride'
require './lib/to_braille'

class ToBrailleTest < MiniTest::Test
  def setup
    @translate = ToBraille.new
    @string_text = "hello"
  end

  def test_attributes_are_instantiated
    assert_instance_of ToBraille, @translate
  end

  def test_can_translate_english_to_braille
    expected = ["0.", "00", ".."], ["0.", ".0", ".."], ["0.", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", "0."]
    assert_equal expected, @translate.translate(@string_text)
  end

  def test_can_write_braille
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, @translate.convert_to_write(@string_text)
  end
end
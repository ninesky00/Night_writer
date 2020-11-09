require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class NightWriteTest < MiniTest::Test
  def setup
    @output_file1 = "./sample_text/test_file1.txt"
    @output_file2 = "./sample_text/test_file2.txt"
    @night_write1 = NightWrite.new(@output_file1)
    @night_write2 = NightWrite.new(@output_file2)
    @braille_text = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    @string_text = "hello"
    @long_string = "this is a forty-one character string test"
  end

  def test_attributes_are_instantiated
    assert_instance_of NightWrite, @night_write1
  end


  def test_can_write_to_file
    @night_write1.write(@braille_text, @output_file1)
    actual = File.open(@output_file1, "r") do |file|
      file.read()
    end
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, actual
  end

  def test_can_translate_english_to_braille
    expected = ["0.", "00", ".."], ["0.", ".0", ".."], ["0.", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", "0."]
    assert_equal expected, @night_write1.translate_to_braille(@string_text)
  end

  def test_can_convert_to_write_braille
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, @night_write1.convert_to_write(@string_text)
    
  end

  def test_can_convert_capital_letters_to_write_braille
    @string_text = "Hello"
    expected = "..0.0.0.0.0.\n..00.00.0..0\n.0....0.0.0.\n"
    assert_equal expected, @night_write1.convert_to_write(@string_text)
  end

  def test_can_break_new_line_when_output_is_too_long
    @night_write2.formatted_writing(@long_string)
    expected = ".00..0.0...0.0..0...000.0..000..0.000...000.0.0.0.00.00.0....0.00..00000...00..0\n" +
    "00000.0...0.0.......0..00000.0...0.0.0....00..00....00.000..0.00000..000..00.00.\n" +
    "0.....0.....0.........0.0.0.00000.0...........0.....0...0...0.0.0...0.....0...0.\n" +
    ".0\n" + "00\n" + "0.\n"
    actual = File.open(@output_file2, "r") do |file|
      file.read()
    end
    assert_equal expected, actual
  end

  def test_can_indicate_capital_letters
    @string_text = "Hello"
    expected = ["..", "..", ".0"], ["0.", "00", ".."], ["0.", ".0", ".."], ["0.", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", "0."]
    assert_equal expected, @night_write1.translate_to_braille(@string_text)
  end

  def test_strings_upcase_count
    @string_text = "Hello World"
    assert_equal 2, @night_write1.upcase_count
  end
end
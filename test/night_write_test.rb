require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class NightWriteTest < MiniTest::Test
  def setup
    @file = "test_file.txt"
    @night_write = NightWrite.new(@file)
    @text = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    @string_text = "hello"
    @long_string = "this is a forty-one character string test"
  end

  def test_attributes_are_instantiated
    assert_instance_of NightWrite, @night_write
  end

  def test_can_write_to_file
    @night_write.write(@text, @file)
    actual = File.open(@file, "r") do |file|
      file.read()
    end
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, actual
  end

  def test_can_break_new_line_when_output_is_too_long
    expected = ".00..0.0...0.0..0...000.0..000..0.000...000.0.0.0.00.00.0....0.00..00000...00..0\n" +
    "00000.0...0.0.......0..00000.0...0.0.0....00..00....00.000..0.00000..000..00.00.\n" +
    "0.....0.....0.........0.0.0.00000.0...........0.....0...0...0.0.0...0.....0...0.\n" +
    ".0\n" + "00\n" + "0.\n"
    assert_equal expected, @translate.limit_to_80_characters_writing(@long_string)
  end
end
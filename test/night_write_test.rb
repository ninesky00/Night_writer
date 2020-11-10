require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class NightWriteTest < MiniTest::Test
  def setup
    @output_file1 = "./sample_text/output_file1.txt"
    @output_file2 = "./sample_text/output_file2.txt"
    @output_file3 = "./sample_text/output_file3.txt"
    @output_file4 = "./sample_text/output_file4.txt"
    @night_write1 = NightWrite.new(@output_file1)
    @night_write2 = NightWrite.new(@output_file2)
    @night_write3 = NightWrite.new(@output_file3)
    @night_write4 = NightWrite.new(@output_file4)
    #added class instances for the purpose of using file apend instead of file write,
    #need some more time to figure out how to code them interchangeably
    @braille_text = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
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

  def test_can_translate_english_to_braille #dictionary method
    string_text = "hello"
    expected = %w(0. 00 ..), %w(0. .0 ..), %w(0. 0. 0.), %w(0. 0. 0.), %w(0. .0 0.)
    assert_equal expected, @night_write1.translate_to_braille(string_text)
  end

  def test_can_convert_to_write_braille
    string_text = "hello"
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    assert_equal expected, @night_write1.convert_to_write(string_text)
  end

  def test_can_convert_capital_letters_to_write_braille
    caps_string = "Hello"
    expected = "..0.0.0.0.0.\n..00.00.0..0\n.0....0.0.0.\n"
    assert_equal expected, @night_write1.convert_to_write(caps_string)
  end

  def test_can_break_new_line_when_output_is_too_long
    long_string = "this is a forty-one character string test"
    @night_write2.formatted_writing(long_string)
    expected = ".00..0.0...0.0..0...000.0..000..0.000...000.0.0.0.00.00.0....0.00..00000...00..0\n" +
    "00000.0...0.0.......0..00000.0...0.0.0....00..00....00.000..0.00000..000..00.00.\n" +
    "0.....0.....0.........0.0.0.00000.0...........0.....0...0...0.0.0...0.....0...0.\n" +
    ".0\n" + "00\n" + "0.\n"
    actual = File.open(@output_file2, "r") do |file|
      file.read()
    end
    assert_equal expected, actual
  end

  def test_can_translate_capital_letters #dictionary method
    caps_string = "Hello"
    expected = %w(.. .. .0), %w(0. 00 ..), %w(0. .0 ..), %w(0. 0. 0.), %w(0. 0. 0.), %w(0. .0 0.)
    assert_equal expected, @night_write1.translate_to_braille(caps_string)
  end

  def test_strings_upcase_count
    caps_string = "Hello World"
    long_string = "this is a forty-one character string test"
    capital_string = "This is a Forty-one Character String Test"
    assert_equal 2, @night_write1.upcase_count(caps_string)
    assert_equal 0, @night_write1.upcase_count(long_string)
    assert_equal 5, @night_write1.upcase_count(capital_string)
  end

  def test_can_write_capital_string
    caps_string = "Hello World"
    @night_write3.formatted_writing(caps_string)
    expected = "..0.0.0.0.0......00.0.0.00\n" +
    "..00.00.0..0....00.0000..0\n" +
    ".0....0.0.0....0.00.0.0...\n"
    actual = File.open(@output_file3, "r") do |file|
      file.read()
    end
    assert_equal expected, actual
  end

  def test_can_translate_numbers_to_braille #dictionary method
    num_string = "5523"
    expected = %w(.0 .0 00), %w(0. .0 ..), %w(0. .0 ..), %w(0. 0. ..), %w(00 .. ..)
    assert_equal expected, @night_write1.translate_to_braille(num_string)
  end

  def test_can_write_numbers_to_braille
    num_string = "5523"
    @night_write4.formatted_writing(num_string)
    expected = ".00.0.0.00\n.0.0.00...\n00........\n"
    actual = File.open(@output_file4, "r") do |file|
      file.read()
    end
    assert_equal expected, actual
  end

  def test_can_count_amount_of_number_switches
    num_string = "5523"
    assert_equal 1, @night_write4.number_switch_count(num_string)
    caps_string = "Hello World"
    assert_equal 0, @night_write4.number_switch_count(caps_string)
    funky_string = "h32uoen5 ap244"
    assert_equal 3, @night_write4.number_switch_count(funky_string)
  end

  def test_total_extra_space_count
    num_string = "5523"
    assert_equal 1, @night_write4.additional_character_count(num_string)
    caps_string = "Hello World"
    assert_equal 2, @night_write4.additional_character_count(caps_string)
    funkier_string = "H32Uops ae32"
    assert_equal 4, @night_write4.additional_character_count(funkier_string)
  end

  def test_can_translate_integrated_long_string_with_numbers_and_letters
    longest_string = "This Is Going To Be Longer Than 9 Characters."
    expected = %w(.. .. .0), %w(.0 00 0.), %w(0. 00 ..), %w(.0 0. ..), %w(.0 0. 0.), 
    %w(.. .. ..), %w(.. .. .0), %w(.0 0. ..), %w(.0 0. 0.), 
    %w(.. .. ..), %w(.. .. .0), %w(00 00 ..), %w(0. .0 0.), %w(.0 0. ..), %w(00 .0 0.), %w(00 00 ..), 
    %w(.. .. ..), %w(.. .. .0), %w(.0 00 0.), %w(0. .0 0.), 
    %w(.. .. ..), %w(.. .. .0), %w(0. 0. ..), %w(0. .0 ..), 
    %w(.. .. ..), %w(.. .. .0), %w(0. 0. 0.), %w(0. .0 0.), %w(00 .0 0.), %w(00 00 ..), %w(0. .0 ..), %w(0. 00 0.), 
    %w(.. .. ..), %w(.. .. .0), %w(.0 00 0.), %w(0. 00 ..), %w(0. .. ..), %w(00 .0 0.), 
    %w(.. .. ..), %w(.0 .0 00), %w(.0 0. ..), 
    %w(.. .. ..), %w(.. .. .0), %w(00 .. ..), %w(0. 00 ..), %w(0. .. ..), %w(0. 00 0.), %w(0. .. ..), %w(00 .. ..), 
    %w(.0 00 0.), %w(0. .0 ..), %w(0. 00 0.), %w(.0 0. 0.), %w(.. 00 .0)
    assert_equal expected, @night_write1.translate_to_braille(longest_string)
  end
end
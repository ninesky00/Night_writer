require 'minitest/autorun'
require 'minitest/pride'
require './lib/english_write'
require './lib/night_read'

class EnglishWriteTest < MiniTest::Test
  def setup
    @file1 = "./sample_text/hello_world.txt"
    @file2 = "./sample_text/br_hello.txt"
    @file3 = "./sample_text/br_long_string.txt"
    @file4 = "./sample_text/br_longest_string.txt"
    @english_write = EnglishWrite.new(@file1)
    @reader = NightRead.new
    @braille_text = @reader.read(@file2)
  end

  def test_attributes_are_instantiated
    assert_instance_of EnglishWrite, @english_write
  end

  #dictionary tests
  def test_can_translate_one_braille_to_english
    @braille_text = "0.\n00\n..\n"
    assert_equal "h", @english_write.translate_to_english(@braille_text)
  end

  def test_can_combine_multipline_braille_input_into_three
    @braille_text = @reader.read(@file3)
    expected = [".00..0.0...0.0..0...000.0..000..0.000...000.0.0.0.00.00.0....0.00..00000...00..0.0",
      "00000.0...0.0.......0..00000.0...0.0.0....00..00....00.000..0.00000..000..00.00.00",
      "0.....0.....0.........0.0.0.00000.0...........0.....0...0...0.0.0...0.....0...0.0."]
    assert_equal expected, @english_write.three_line_braille(@braille_text)
  end

  def test_braille_pairs_helper_method
    expected = [["0.", "0.", "0.", "0.", "0."], ["00", ".0", "0.", "0.", ".0"], ["..", "..", "0.", "0.", "0."]]
    assert_equal expected, @english_write.braille_pairs(@braille_text)
  end

  def test_transpose_braille_pairs_back_to_braille_letters
    expected = [["0.", "00", ".."], ["0.", ".0", ".."], ["0.", "0.", "0."], ["0.", "0.", "0."], ["0.", ".0", "0."]]
    assert_equal expected, @english_write.transpose_letters(@braille_text)
  end

  def test_can_translate_braille_string_to_english
    assert_equal "hello", @english_write.translate_to_english(@braille_text)
  end

  def test_can_translate_long_braille_string_to_english
    braille_text = @reader.read(@file3)
    assert_equal "this is a forty-one character string test", @english_write.translate_to_english(braille_text)
  end

  def test_can_translate_longest_braille_string_to_english
    braille_text = @reader.read(@file4)
    assert_equal "This Is Going To Be Longer Than 9 Characters.", @english_write.translate_to_english(braille_text)
  end

  def test_can_write_english_to_destination
    braille_text = "..0.0.0.0.0......00.0.0.00
    ..00.00.0..0....00.0000..0
    .0....0.0.0....0.00.0.0..."
    @english_write.write(braille_text)
    actual = File.open(@file1, "r") do |file|
      file.read()
    end
    assert_equal "Hello World", actual
  end
end
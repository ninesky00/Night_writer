require 'minitest/autorun'
require 'minitest/pride'
require './lib/english_write'
require './lib/night_read'

class EnglishWriteTest < MiniTest::Test
  def setup
    @file1 = "./sample_text/sample_english.txt"
    @file2 = "./sample_text/sample_braille.txt"
    @english_write = EnglishWrite.new(@file1)
    @reader = NightRead.new
    @braille_text = @reader.read(@file2)
  end

  def test_attributes_are_instantiated
    assert_instance_of EnglishWrite, @english_write
  end

  def test_can_translate_one_braille_to_english
    @braille_text = "0.\n00\n..\n"
    assert_equal "h", @english_write.translate_to_english(@braille_text)
  end

  def test_can_translate_braille_string_to_english
    assert_equal "hello", @english_write.translate_to_english(@braille_text)
  end
end
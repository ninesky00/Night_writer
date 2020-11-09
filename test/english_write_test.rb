require 'minitest/autorun'
require 'minitest/pride'
require './lib/english_write'

class EnglishWriteTest < MiniTest::Test
  def setup
    @file1 = "./sample_text/sample_english.txt"
    @english_write = EnglishWrite.new(@file1)
    @braille_text = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
  end

  def test_attributes_are_instantiated
    assert_instance_of EnglishWrite, @english_write
  end

  def test_can_translate_braille_to_english
    assert_equal "hello", @english_write.translate_to_english(@braille_text)
  end

end
require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'

class NightWriterTest < MiniTest::Test
  def setup
    @night_writer = NightWriter.new
    ARGV[0] = 'message.txt'
  end

  def test_attributes_are_instantiated
    assert_instance_of NightWriter, @night_writer
  end

  def test_can_read_argument_file
    assert_equal "hello world", @night_writer.read
  end
  
  def test_can_translate_text_into_braille
    @night_writer.read
    assert_equal %w(0. 00 ..), @night_writer.translate
  end

  def test_can_write_to_argument_file
    skip
  end
end
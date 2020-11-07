require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'

class NightReadTest < MiniTest::Test
  def setup
    @night_read = NightRead.new
    ARGV[0] = 'message.txt'
  end

  def test_attributes_are_instantiated
    assert_instance_of NightRead, @night_read
  end

  def test_can_read_argument_file
    assert_equal "hello world", @night_read.read
  end
  
  def test_can_translate_text_into_braille
    @night_read.read
    assert_equal %w(0. 00 ..), @night_read.translate
  end

  def test_can_write_to_argument_file
    skip
  end
end
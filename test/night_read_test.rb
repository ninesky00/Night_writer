require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'

class NightReadTest < MiniTest::Test
  def setup
    @night_read = NightRead.new
    ARGV[0] = './sample_text/hello_world.txt'
    @file1 = "./sample_text/test_file2.txt"
  end

  def test_attributes_are_instantiated
    assert_instance_of NightRead, @night_read
  end

  def test_can_read_argument_file
    assert_equal "hello world", @night_read.read(ARGV[0])
  end

  def test_can_break_braille_text_longer_than_240_to_three_lines
    assert_equal 3, @night_read.read(@file1).split.count
  end
end
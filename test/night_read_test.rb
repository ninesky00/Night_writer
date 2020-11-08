require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_read'

class NightReadTest < MiniTest::Test
  def setup
    @night_read = NightRead.new
    ARGV[0] = './sample_text/hello_world.txt'
  end

  def test_attributes_are_instantiated
    assert_instance_of NightRead, @night_read
  end

  def test_can_read_argument_file
    assert_equal "hello world", @night_read.read(ARGV[0])
  end
end
require_relative 'test_helper'

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
    assert_equal "Hello World", @night_read.read(ARGV[0])
  end
end
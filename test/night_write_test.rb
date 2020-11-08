require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class NightWriteTest < MiniTest::Test
  def setup
    @night_write = NightWrite.new
    @text = "0.0.0.0.0.\n00.00.0..0\n....0.0.0.\n"
    @file = "test_file.txt"
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
end
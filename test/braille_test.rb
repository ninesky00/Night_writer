require 'minitest/autorun'
require 'minitest/pride'
require './lib/braille'

class BrailleTest < MiniTest::Test
  def setup
    @braille = Braille.new("hello world")
  end

  def test_attributes_are_instantiated
    assert_instance_of Braille, @braille
  end

end
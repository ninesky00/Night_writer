require 'minitest/autorun'
require 'minitest/pride'
require './lib/to_braille'

class ToBrailleTest < MiniTest::Test
  def setup
    @translate = ToBraille.new
  end

  def test_attributes_are_instantiated
    assert_instance_of ToBraille, @translate
  end

  
end
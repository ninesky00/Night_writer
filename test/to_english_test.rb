require 'minitest/autorun'
require 'minitest/pride'
require './lib/'

class Test < MiniTest::Test
  def setup
    @english = ToEnglish.new
  end

  def test_attributes_are_instantiated
    assert_instance_of ToEnglish, @english
  end
end
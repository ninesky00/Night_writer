require './lib/dictionary'
class EnglishWrite
  include Dictionary
  def initialize(destination)
    @destination = destination
  end

  def convert_to_write(braille_string)
    translate_to_english(braille_string)
  end

  def write(braille_string)
    File.open(@destination, "w") do |file|
      file.write(convert_to_write(braille_string))
    end
  end
end
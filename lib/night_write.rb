require './lib/dictionary'

class NightWrite
  include Dictionary
  def initialize(destination)
    @destination = destination
  end

  def write(braille_text, destination)
    File.open(destination, "a") do |file|
      file.write(braille_text)
    end
  end

  def convert_to_write(string)
    output = translate_to_braille(string)
    line1 = output.transpose[0].join
    line2 = output.transpose[1].join
    line3 = output.transpose[2].join
    writing_string = line1 + "\n" + line2 + "\n" + line3 + "\n"
  end

  def formatted_writing(string)
    if string.length <= 40
      output = convert_to_write(string)
      write(output, @destination)
    else 
      first40 = string.slice(0..39)
      rest = string.slice(40..-1)
      formatted_writing(first40)
      formatted_writing(rest)
    end
  end
end
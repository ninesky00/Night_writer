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

  def upcase_count(string)
    upcase_count, space_count = 0, 0
    string.chars do |char|
      upcase_count += 1 if char == char.upcase
      space_count += 1 if char == " "
    end
    total_count = upcase_count - space_count
  end

  def formatted_writing(string)
    if string.length <= (40 - upcase_count(string))
      output = convert_to_write(string)
      write(output, @destination)
    else 
      first40 = string.slice(0..(39 - upcase_count(string)))
      rest = string.slice((40 - upcase_count(string))..-1)
      formatted_writing(first40)
      formatted_writing(rest)
    end
  end
end
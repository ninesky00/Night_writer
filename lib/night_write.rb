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
    string.scan(/[A-Z]/).count
  end

  def number_switch_count(string)
    count = 0
    string.each_char.with_index do |char, idx|
      if char.match(/\d/)
      count += 1 if string[idx + 1] == nil || string[idx + 1].match(/\D/)
      end
    end
    count
  end

  def formatted_writing(string)
    #what is the proper syntax for below, seems convaluted
    if string.length <= (40 - upcase_count(string) - number_switch_count(string))
      output = convert_to_write(string)
      write(output, @destination)
    else 
      first40 = string.slice(0..(39 - upcase_count(string) - number_switch_count(string)))
      rest = string.slice((40 - upcase_count(string))..-1)
      formatted_writing(first40)
      formatted_writing(rest)
    end
  end
end
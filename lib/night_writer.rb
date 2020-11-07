require './lib/night_read'
require './lib/to_braille'
require './lib/to_english'
require './lib/night_write'

read_file, write_file = ARGV[0], ARGV[1]
reader = NightRead.new
text = reader.read(read_file)
translator = ToBraille.new
braille_text = translator.convert_to_write(text)
writer = NightWrite.new
writer.write(braille_text, write_file)
# require 'pry';binding.pry

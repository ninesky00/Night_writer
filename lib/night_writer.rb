require './lib/night_read'
require './lib/to_english'
require './lib/night_write'

read_file, destionation = ARGV[0], ARGV[1]
reader = NightRead.new
text = reader.read(read_file)
writer = NightWrite.new(destionation)
writer.limit_to_80_characters_writing(text)
puts "Created '#{ARGV[1]}' containing #{text.length} characters"
# require 'pry';binding.pry

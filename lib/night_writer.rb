require_relative 'night_read'
require_relative 'night_write'
require_relative 'english_write'

input, output = ARGV[0], ARGV[1]
reader = NightRead.new
night_writer = NightWrite.new(output)
english_writer = EnglishWrite.new(output)
text = reader.read(input)
if text.match(/0.+/)
  english_writer.write(text)
  puts "Created '#{ARGV[1]}' containing #{text.length} characters"
elsif text.match(/\w/)
  night_writer.formatted_writing(text)
  puts "Created '#{ARGV[1]}' containing #{text.length} characters"
end

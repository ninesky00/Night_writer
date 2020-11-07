class NightRead
  def initialize
    @string_text = ""
  end

  def read
    file = File.open(ARGV[0], "r")
    text = file.read()
    file.close
    @string_text = text
  end

end
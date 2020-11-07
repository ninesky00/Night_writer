class NightWrite
  def write(braille_text, file_name)
    File.open(file_name, "w") do |file|
      file.write(braille_text[0] + "\n")
      file.write(braille_text[1] + "\n")
      file.write(braille_text[2] + "\n")
    end
  end
end
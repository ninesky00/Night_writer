class NightWrite
  def write(braille_text, file_name)
    File.open(file_name, "w") do |file|
      file.write(braille_text)
    end
  end
end
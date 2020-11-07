class NightRead
  def read(file_name)
    file = File.open(file_name, "r")
    text = file.read()
    file.close
    text
  end
end
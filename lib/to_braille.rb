class ToBraille
  def initialize
    @translation_hash = {
  "a" => %w(0. .. ..), "b" => %w(0. 0. ..), "c" => %w(00 .. ..),
  "d" => %w(00 .0 ..), "e" => %w(0. .0 ..), "f" => %w(00 0. ..),
  "g" => %w(00 00 ..), "h" => %w(0. 00 ..), "i" => %w(.0 0. ..),
  "j" => %w(.0 00 ..), "k" => %w(0. .. 0.), "l" => %w(0. 0. 0.),
  "m" => %w(00 .. 0.), "n" => %w(00 .0 0.), "o" => %w(0. .0 0.),
  "p" => %w(00 0. 0.), "q" => %w(00 00 0.), "r" => %w(0. 00 0.),
  "s" => %w(.0 0. 0.), "t" => %w(.0 00 0.), "u" => %w(0. .. 00),
  "v" => %w(0. 0. 00), "w" => %w(.0 00 .0), "x" => %w(00 .. 00),
  "y" => %w(00 .0 00), "z" => %w(0. .0 00), "!" => %w(.. 00 0.),
  "'" => %w(.. .. 0.), "," => %w(.. 0. ..), "-" => %w(.. .. 00),
  "." => %w(.. 00 .0), "?" => %w(.. 0. 00), " " => %w(.. .. ..),
  "numbers" => %w(.0 .0 00)
                        }
  end

  def translate(string)
    braille_array = []
    string.each_char do |char|
      braille_array << @translation_hash[char]
    end
    braille_array
  end
  
  def convert_to_write(string)
    output = translate(string)
    line1 = output.transpose[0].join
    line2 = output.transpose[1].join
    line3 = output.transpose[2].join
    # line1, line2, line3 = "", "", ""
    # output = translate(string)
    # output.each do |braille|
    #   line1 += braille[0]
    #   line2 += braille[1]
    #   line3 += braille[2]
    # end
    writing_string = line1 + "\n" + line2 + "\n" + line3 + "\n"
  end
end
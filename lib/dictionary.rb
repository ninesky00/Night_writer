module Dictionary
  def translation_hash
  translation_hash = {
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

  def translate_to_braille(string)
    hash = translation_hash
    braille_array = []
    string.each_char do |char|
      braille_array << hash[char]
    end
    braille_array
  end

  def translate_to_english(braille_string)
    hash = translation_hash
    braille_pairs = []
    string = braille_string.split
    string.each do |each|
      braille_pairs << each.scan(/../)
    end
    braille_letters = braille_pairs[0].zip(braille_pairs[1], braille_pairs[2])
    letters_array = braille_letters.map do |letter|
      hash.key(letter)
    end
    letters_array.join
  end

end
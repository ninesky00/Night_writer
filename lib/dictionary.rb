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
    "numbers" => %w(.0 .0 00), "capital" => %w(.. .. .0)
                          }
  end

  def translate_to_braille(string)
    hash = translation_hash
    braille_array = []
    string.each_char do |char|
      if char.match(/[A-Z]/)
        braille_array << hash["capital"]
        braille_array << hash[char.downcase]
      else
      braille_array << hash[char]
      end
    end
    braille_array
  end

  def translate_to_english(braille_string)
    hash = translation_hash
    braille_letters = transpose_letters(braille_string)
    letters_array = braille_letters.map do |letter|
      hash.key(letter)
    end
    letters_array.join.gsub(/capital./) {|match| match[-1].upcase}
    #only captures shift letters at the moment, does not capture caps lock
  end

  def three_line_braille(braille_string)
    top, middle, bottom = [], [], []
    strings = braille_string.split
    strings.each_with_index do |string, index|
      top << string if index % 3 == 0
      middle << string if index % 3 == 1
      bottom << string if index % 3 == 2
    end
    [top.join, middle.join, bottom.join]
  end

  def braille_pairs(braille_string)
    braille_pairs = []
    three_lines = three_line_braille(braille_string)
    three_lines.each do |each|
      braille_pairs << each.scan(/../)
    end
    braille_pairs
  end
  
  def transpose_letters(braille_string)
    pairs = braille_pairs(braille_string)
    braille_letters = pairs[0].zip(pairs[1], pairs[2])
  end
end
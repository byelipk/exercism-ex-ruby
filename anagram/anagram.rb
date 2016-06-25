class Anagram
  attr_reader :raw, :sorted

  def initialize(raw)
    raw.downcase!

    @raw = raw
    @sorted = raw.chars.sort
  end

  def match(words)
    words.select do |word|
      if word.downcase != raw
        word.downcase.chars.sort == sorted
      end
    end
  end
end

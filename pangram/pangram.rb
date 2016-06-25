class Pangram
  NOT_IN_ALPHABET = /[^a-zA-Z]/
  ALPHABET_LENGTH = 26

  def self.is_pangram?(str)
    str.gsub! NOT_IN_ALPHABET, ""
    str.downcase!

    str.chars.sort.uniq.length == ALPHABET_LENGTH
  end
end

module BookKeeping
  VERSION = 2
end

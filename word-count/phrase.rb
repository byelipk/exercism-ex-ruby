class Phrase
  attr_reader :text
  attr_accessor :frequency

  def initialize(text)
    @text = text
  end

  def word_count
    @word_count ||= generate_histogram
  end

  private

  def generate_histogram
    text.scan(word_definition).reduce(Hash.new(0)) do |freq, word|
      freq[word.downcase] += 1
      freq
    end
  end

  def word_definition
    /['\w]+/
  end
end

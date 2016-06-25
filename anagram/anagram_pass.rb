require 'pry'

class Anagram
  def self.new(word)
    Detector.new(detectable: word)
  end
end

class DefaultFormatter
  def format(array)
    array.flatten
  end
end

class WordFormatter
  def format(word)
    word.downcase
  end
end

class DefaultValidator
  def validate(word, array)
    array.delete_if do |w|
      w.downcase == word.downcase || w.length != word.length
    end
  end
end

class DefaultMatcher

  attr_reader :formatter

  def initialize(formatter: WordFormatter.new)
    @formatter = formatter
  end

  def chars_for(word)
    formatter.format(word).chars
  end

  def sorted_chars_for(word)
    chars_for(word).sort
  end

  def extract_matches(chars, list)
    list.select { |w| sorted_chars_for(w) == chars }
  end

  def match(word, list)
    extract_matches(sorted_chars_for(word), list)
  end
end

class Detector
  attr_reader :detecable, :formatter, :validator, :matcher

  def initialize( detectable: word,
                  formatter: DefaultFormatter.new,
                  validator: DefaultValidator.new,
                  matcher:   DefaultMatcher.new )

    @detecable = detectable
    @formatter = formatter
    @validator = validator
    @matcher   = matcher
  end

  def match(*args)
    matcher.match(detecable, validated_list(args))
  end

  private

  def formatted_list(args)
    formatter.format(args)
  end

  def validated_list(args)
    validator.validate(detecable, formatted_list(args))
  end
end

require_relative './database'

class Scrabble
  attr_reader :chars, :db

  def initialize(word, database: Database.new)
    @db     = database
    @chars  = SafeWord.new(word)
  end

  def self.score(word)
    Scrabble.new(word).score
  end

  def score
    @score ||= scores.inject(0) { |sum, int| sum + int }
  end

  def scores
    @scores ||= chars.map { |c| db.fetch(c) }
  end
end

class SafeWord
  def self.new(word)
    if word.respond_to?(:chars)
      word.gsub!(/\t|\n|\s/, "")
      word.chars
    else
      []
    end
  end
end

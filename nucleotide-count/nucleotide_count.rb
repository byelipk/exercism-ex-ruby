class Nucleotide
  def self.from_dna(string)
    DNA.new( strand: SafeStrand.validate(string, DefaultStrand.new) )
  end
end

class SafeStrand
  def self.validate(string, defaults)
    string.chars.each do |char|
      defaults.fetch(char) do
        raise ArgumentError
      end
    end

    string
  end
end

class DNA
  attr_reader :histogram

  def initialize(strand: String.new, dna: DefaultStrand.new)
    @histogram = Histogram.generate(strand, dna)
  end

  def count(char)
    histogram[char]
  end
end

class DefaultStrand
  def self.new
    { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
  end
end

class Histogram
  def self.generate(string, default)
    string.chars.reduce(default) do |hash, char|
      hash[char] += 1
      hash
    end
  end
end

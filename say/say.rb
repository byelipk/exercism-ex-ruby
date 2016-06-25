class Say
  attr_reader :number, :chars, :db

  def initialize(n)
    @number = n
    @chars  = hashmap.build
    @db     = Database.new
  end

  def in_english
    db.lookup[number]
  end

  def hashmap
    @hashmap ||= Hashmap.new(number)
  end
end

class Hashmap
  attr_reader :n
  def initialize(n)
    @n = n
  end

  def build
    n.to_s.chars
  end
end

class Database
  def lookup
    {
      0 => "zero",
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine",
      10 => "ten",
      11 => "eleven",
      12 => "twelve",
      13 => "thirteen",
      14 => "fourteen",
      15 => "fifteen",
      16 => "sixteen",
      17 => "seventeen",
      18 => "eighteen",
      19 => "nineteen",
      20 => "twenty"
    }
  end
end

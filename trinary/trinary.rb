class Trinary
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_decimal
    return 0 if number =~ /[^012]/
    number.chars.inject(0) do |decimal, digit|
      (decimal * 3) + digit.to_i
    end
  end
end

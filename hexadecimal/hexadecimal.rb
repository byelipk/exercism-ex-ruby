require 'pry'
require 'delegate'

# Steps:
# ======
# 1. Get the last digit of the hex number, call this digit the currentDigit.
# 2. Make a variable, let's call it power. Set the value to 0.
# 3. Multiply the current digit with (16^power), store the result.
# 4. Increment power by 1.
# 5. Set the the currentDigit to the previous digit of the hex number.
# 6. Repeat from step 3 until all digits have been multiplied.
# 7. Sum the result of step 3 to get the answer number.
#
#
# Convert the number 1128 HEXADECIMAL to DECIMAL
#
# In Ruby:
# "1128".to_i(16)
#
# 8 x (16^0) => 8      Start from the last digit of the number.
#                      In this case, the number is 1128.
#                      The last digit of that number is 8.  Note that any
#                      number the power of 0 is always 1.
#
# 2 x (16^1) => 32     Process the previous, which is 2.  Multiply that
#                      number with an increasing power of 16.
#
# 1 x (16^2) => 256    Process the previous digit, which is 1.
#
# 1 x (16^3) => 4096   Process the previous digit, which is 1.
#
#                      Here, we stop because there's no more digit to process
#
# ANSWER => 4392       This number comes from the sum of the RESULTS
#                      (8 + 32 + 256 + 4096) = 4392
#
# A = 10
# B = 11
# C = 12
# D = 13
# E = 14
# F = 15


class Hexadecimal
  attr_reader :collection

  def initialize(string)
    @collection = HexCollection.new(string)
  end

  def to_decimal
    collection.sum
  end
end

class HexCollection < DelegateClass(Array)
  def initialize(string)
    hex_values = string.chars.map do |c|
      HexValue.new(c)
    end.reverse

    super(hex_values)
  end

  def sum
    safe_values.reduce(0) { |sum, v| sum += v }
  end

  def safe_values
    map = []

    each_with_index do |v, i|
      map << (v.to_hex * (16 ** i))
    end

    map

  rescue InvalidHexValueError
    [0]
  end
end

class HexValue
  attr_reader :char

  def initialize(char)
    @char = char
  end

  def to_hex
    HexDictionary.conversions.fetch(char) do
      raise InvalidHexValueError, "#{char} is not a valid hex value."
    end
  end
end

class InvalidHexValueError < Exception
end

class HexDictionary
  def self.conversions
    {
      "0" => 0,
      "1" => 1,
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "0" => 0,
      "a" => 10,
      "b" => 11,
      "c" => 12,
      "d" => 13,
      "e" => 14,
      "f" => 15,
    }
  end
end

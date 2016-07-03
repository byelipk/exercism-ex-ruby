require 'pry'
require 'pry-byebug'

class RunLengthEncoding
  def self.encode(input)
    MyEncoding.new(input).run
  end

  def self.decode(input)
    MyDecoding.new(input).run
  end
end

class MyEncoding
  attr_reader :chars, :compressed

  def initialize(input)
    @chars      = input.chars
    @compressed = String.new
  end

  def run
    count    = 0
    current  = nil
    previous = nil

    chars.each_with_index do |c, i|
      current  = c
      previous = chars[i - 1] if i > 0

      if current == previous
        count += 1
      else
        write_to_buffer(count, previous) if previous
        count = 1
      end

      if chars.size == (i + 1)
        write_to_buffer(count, current)
      end
    end

    compressed
  end

  def write_to_buffer(count, char)
    compressed << (count > 1 ? count : "").to_s << char
  end
end

class MyDecoding
  attr_reader :input, :decompressed

  def initialize(input)
    @input        = input
    @decompressed = String.new
  end

  def run
    loop do
      break if input.size == 0

      # Find number of times to append char
      # to output buffer
      i = number_of_times_to_append_char

      # Take the char we want to append
      c = input.slice!(0,1)

      # Append it to the output `i` times
      i.times { decompressed << c }
    end

    decompressed
  end

  private

    def number_of_times_to_append_char
      if is_integer?(input[0])
        m = input.match(/[0-9]+/)
        s = m.to_s
        i = s.to_i

        # Lose the chars which correspond to
        # the integer value
        input.slice!(0, s.size)

        i
      else
        1
      end
    end

    def is_integer?(char)
      char.match(/[0-9]/)
    end
end

module BookKeeping
  VERSION = 2
end

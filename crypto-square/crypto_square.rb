require 'pry'
class Crypto
  def self.new(text)
    Square.new(raw: text)
  end
end

class Square

  attr_reader :raw, :normalized, :size, :measurer, :segmenter, :cipher

  def initialize( raw: text,
                  substituter: DefaultSubstituter.new,
                  downcaser: DefaultDowncaser.new,
                  measurer: DefaultMeasurer.new,
                  segmenter: DefaultSegmenter.new,
                  cipher: DefaultCipher.new )

    @raw        = raw
    @measurer   = measurer
    @segmenter  = segmenter
    @cipher     = cipher
    @normalized = downcaser.run(substituter.sub(raw))
    @size       = measurer.measure(normalized)
  end

  def normalize_plaintext
    normalized
  end

  def plaintext_segments
    segmenter.batches_for(normalized, size) do |batch|
      batch.join('')
    end
  end

  def ciphertext
    transposed_text.join('').strip
  end

  def normalize_ciphertext
    transposed_text.join(' ').strip
  end

  private

  def transposed_text
    cipher.derive(plaintext_segments)
  end
end

class DefaultSubstituter
  def sub(text)
    text.gsub(/\W/, "")
  end
end

class DefaultDowncaser
  def run(text)
    text.downcase
  end
end

class DefaultMeasurer
  def measure(text)
    Math.sqrt(text.length).ceil
  end
end

class DefaultSegmenter
  def batches_for(text, size)
    segments = []
    text.chars.each_slice(size) do |batch|
      segments << yield(batch)
    end
    segments
  end
end

class DefaultCipher
  def derive(segments)
    text = []
    0.upto(segments.size) do |i|
      crypto = []
      segments.each do |word|
        crypto << word[i]
      end

      text << crypto.join('').split
    end

    text
  end
end

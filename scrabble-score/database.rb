class Database
  ONE_POINT   = %i(A E I O U L N R S T)
  TWO_POINT   = %i(D G)
  THREE_POINT = %i(B C M P)
  FOUR_POINT  = %i(F H V W Y)
  FIVE_POINT  = %i(K)
  EIGHT_POINT = %i(J X)
  TEN_POINT   = %i(Q Z)

  attr_reader :map

  def initialize
    @map = init_map
  end

  def init_map
    map     = {}

    [
      [ONE_POINT,   1],
      [TWO_POINT,   2],
      [THREE_POINT, 3],
      [FOUR_POINT,  4],
      [FIVE_POINT,  5],
      [EIGHT_POINT, 8],
      [TEN_POINT,   10]
    ].each do |set|
      list  = set.first
      score = set.last

      list.each do |letter|
        map[letter.to_s] = score
      end
    end

    map
  end

  def fetch(char)
    map.fetch(char.upcase, "Error fetching char from map!")
  end
end

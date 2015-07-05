require 'pry'

class Bst
  def self.new(d)
    Node.new(store: NonEmptyStore.new(d))
  end
end

############################################################

class EmptyStore
  attr_reader :data
end

class NonEmptyStore
  attr_reader :data
  def initialize(data)
    @data = data
  end
end

############################################################

class DefaultInserter

  attr_reader :direction

  def insert(node, value)
    initialize_direction(node, value) do
      direction.push(node, value)
    end
  end

  private

  def initialize_direction(node, value)
    @direction = case node.data <=> value
    when 1  then LeftSide.new
    when -1 then RightSide.new
    when 0  then DefaultSide.new
    end

    yield
  end
end

class LeftSide
  def push(node, value)
    node.left.insert(value) || node.left = Node.new(store: NonEmptyStore.new(value))
  end
end

class RightSide
  def push(node, value)
    node.right.insert(value) || node.right = Node.new(store: NonEmptyStore.new(value))
  end
end

class DefaultSide
  def push(node, value)
    false
  end
end

############################################################


class Node

  include Enumerable

  attr_reader :data, :inserter, :store
  attr_accessor :left, :right

  def initialize( store: EmptyStore.new,
                  inserter: DefaultInserter.new,
                  left: EmptyNode.new,
                  right: EmptyNode.new )

    @store    = store
    @data     = store.data
    @inserter = inserter
    @left     = left
    @right    = right
  end

  def insert(value)
    inserter.insert(self, value)
  end

  def each(&block)
    left.each(&block)
    block.call(self.data)
    right.each(&block)
  end

end

class EmptyNode

  include Enumerable

  attr_reader :data

  def insert(value)
    false
  end

  def each(&block)
    return
  end
end

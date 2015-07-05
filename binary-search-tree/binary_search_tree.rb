
class Bst
  def self.new(d)
    Node.new( store: NonEmptyStore.new(d) )
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

class EmptyInserter
  def insert(value)
    false
  end
end

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

class DefaultEnumerator
  def each(node, &block)
    node.left.each(&block)
    block.call(node.data)
    node.right.each(&block)
  end
end

class EmptyEnumerator
  def each(&block)
    return
  end
end

############################################################
class Node

  include Enumerable

  attr_reader :data, :inserter, :enumerator
  attr_accessor :left, :right

  def initialize( store: EmptyStore.new,
                  inserter: DefaultInserter.new,
                  enumerator: DefaultEnumerator.new )

    @data       = store.data
    @inserter   = inserter
    @enumerator = enumerator
    @left       = EmptyNode.new
    @right      = EmptyNode.new
  end

  def insert(value)
    inserter.insert(self, value)
  end

  def each(&block)
    enumerator.each(self, &block)
  end

end

class EmptyNode

  include Enumerable

  attr_reader :data

  def insert(value)
    EmptyInserter.new.insert(value)
  end

  def each(&block)
    EmptyEnumerator.new.each(&block)
  end

end

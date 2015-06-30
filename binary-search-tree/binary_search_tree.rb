# require 'pry'
#
# class DefaultAttacher
#   def attach(branch, leaf)
#     if branch.data >= leaf.data
#       branch.left = leaf
#     else
#       branch.right = leaf
#     end
#
#     branch
#   end
# end
#
# class Bst
#   def self.new(number)
#     NonEmpty.new(number)
#   end
# end
#
# class NonEmpty
#
#   attr_reader :data, :attacher
#   attr_accessor :left, :right
#
#   def initialize( data,
#                   left: Empty.new,
#                   right: Empty.new,
#                   attacher: DefaultAttacher.new )
#
#     @data     = data
#     @left     = left
#     @right    = right
#     @attacher = attacher
#   end
#
#   def contains(number)
#     if number < data
#       left.contains(number)
#     elsif number > data
#       right.contains(number)
#     else
#       true
#     end
#   end
#
#   def insert(number)
#     attacher.attach( self,
#                      NonEmpty.new(
#                       number,
#                       attacher: attacher ))
#   end
# end
#
# class Empty
#
#   def contains
#     false
#   end
#
#   def data
#   end
#
#   def insert(number)
#     attacher.attach( self,
#                      NonEmpty.new(
#                       number,
#                       attacher: attacher ))
#   end
# end

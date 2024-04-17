# frozen_string_literal: true

module BST
  # Binary Search Tree

  # compare @data of Nodes
  module Comparable
  end

  # Each node of the tree is an object holding data, knows its children
  class Node
    attr_accessor :left, :right, :data

    def initialize(data)
      @data = data
    end
  end

  # the tree itself is an object - recursion will create several
  class Tree
    attr_accessor :root

    def initialize(arr)
      @root = nil
      sorted = clean(arr)
      last = sorted.length - 1
      build_tree(sorted, 0, last)
    end

    def clean(arr)
      arr.sort.uniq
    end

    def build_tree(arr, beginning, ending)
      p 'one lap'
      p arr
      p beginning
      p ending
      return if beginning > ending

      # returns 0-level root node
      # creates balanced binary tree full of Node objects
      # find middle element, set it as root
      middle = (beginning + ending) / 2
      @root = Node.new(arr[middle])
      # recursively do the same to left and right halves of the array
      @root.left = build_tree(arr, beginning, middle - 1)
      @root.right = build_tree(arr, middle + 1, ending)
      @root
    end

    def insert(node)
      # more efficient to not use the array method
    end

    def delete(node)
      # more efficient to not use the array method
    end

    def find(value)
      # returns node with given value
    end

    def level_order
      # accepts block; breadth-first order
      # yield each node to provided block
    end

    def inorder
      # accepts block
      # depth-first order
      # yield to provided block; return array if no block given
    end

    def preorder
      # accepts block
      # depth-first order
      # yield to provided block; return array if no block given
    end

    def postorder
      # accepts block
      # depth-first order
      # yield to provided block; return array if no block given
    end

    def height(node)
      # number of edges in longest path from given node to leaf node
    end

    def depth(node)
      # number of edges in path from given node to the tree's root
    end

    def balanced?
      # check if difference between heights of left subtree and right subtree <= 1
    end

    def rebalance
      # give a traversal method to create a new array
      # give the new array to build_tree
    end

    # pre-made pretty print for visualization
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
  end
end

# driver script
rand_arr = Array.new(15) { rand(1..100) }
p rand_arr
rand_tree = BST::Tree.new(rand_arr)
# rand_tree.balanced? # check balance
# print all elements in level, pre, post, and in order
# unbalance tree by adding several numbers > 100
# rand_tree.balanced? # check balance
# print all elements in level, pre, post, and in order
p rand_tree

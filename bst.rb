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
      @left = nil
      @right = nil
    end
  end

  # the tree itself is an object - recursion will create several
  class Tree
    attr_accessor :root, :size

    def initialize(arr = [])
      @root = build_tree(arr.sort.uniq)
      @size = 0
    end

    def build_tree(arr)
      return nil if arr.empty?

      # returns 0-level root node
      # creates balanced binary tree full of Node objects
      # find middle element, set it as root
      middle = arr.length / 2
      node = Node.new(arr[middle])
      # recursively do the same to left and right halves of the array
      node.left = build_tree(arr[0...middle])
      node.right = build_tree(arr[middle + 1..])
      node
    end

    def insert(value, node = @root)
      return Node.new(value) if node.nil?

      if value < node.data
        node.left = insert(value, node.left)
      elsif value > node.data
        node.right = insert(value, node.right)
      end

      node
    end

    def delete(value, node = @root)
      return nil if node.nil?

      if value < node.data
        node.left = delete(value, node.left)
      elsif value > node.data
        node.right = delete(value, node.right)
      else
        if node.left.nil?
          temp = node.right
          node = nil
          return temp
        elsif node.right.nil?
          temp = node.left
          node = nil
          return temp
        end
        temp = find_min(node.right)
        node.data = temp.data
        node.right = delete(temp.data, node.right)
      end
      node
    end

    def find_min(node)
      current_min = node
      current_min = current_min.left while current_min.left
      current_min
    end

    def find(value)
      # returns node with given value
    end

    def level_order
      # accepts block; breadth-first order
      # yield each node to provided block
    end

    def inorder(node)
      return if node.nil?

      # accepts block
      # depth-first order
      # yield to provided block; return array if no block given
      inorder(node.left)
      puts node.data
      inorder(node.right)
    end

    def preorder(node)
      return if node.nil?

      # accepts block!!
      # yield to provided block; return array if no block given!!
      puts node.data
      preorder(node.left)
      preorder(node.right)
    end

    def postorder(node)
      # accepts block
      # depth-first order
      # yield to provided block; return array if no block given
      return if node.nil?

      postorder(node.left)
      postorder(node.right)
      puts node.data
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
# rand_arr = Array.new(15) { rand(1..100) }
# last = sanitized_arr.length - 1
test = [1, 2, 3, 4, 5, 6, 7]
tree = BST::Tree.new(test)
# rand_tree.balanced? # check balance
# print all elements in level, pre, post, and in order
# unbalance tree by adding several numbers > 100
# rand_tree.balanced? # check balance
# print all elements in level, pre, post, and in order

tree.inorder(tree.root)
tree.pretty_print
tree.insert(8)
tree.pretty_print
tree.delete(6)
tree.pretty_print

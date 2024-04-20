# frozen_string_literal: true

module BST
  # Binary Search Tree

  # Each node of the tree is an object holding data, knows its children
  class Node
    attr_accessor :left, :right, :data

    def initialize(data)
      @data = data
      @left = nil
      @right = nil
    end

    def to_s
      @data.to_s
    end
  end

  # the tree is an object
  class Tree
    attr_accessor :root, :list

    def initialize(arr = [])
      @list = arr.sort.uniq
      @root = build_tree(@list)
    end

    def build_tree(arr)
      return nil unless arr.is_a?(Array) && !arr.empty?

      # returns 0-level root node
      # creates balanced binary tree full of Node objects
      middle = arr.length / 2
      node = Node.new(arr[middle])
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

    def find(value, node = @root)
      # returns node with given value
      return nil if node.nil?

      if value < node.data
        find(value, node.left)
      elsif value > node.data
        find(value, node.right)
      else
        pretty_print(node)
      end
    end

    def level_order(node = @root)
      return if node.nil?

      queue = [node]
      result = []
      until queue.empty?
        yield(queue) if block_given?
        node = queue.shift
        result << node.data
        queue << node.left if node.left
        queue << node.right if node.right
      end
      result
    end

    def inorder(node = @root)
      return if node.nil?

      if block_given?
        yield(node)
      else
        inorder(node.left)
        puts node.data
        inorder(node.right)
      end
    end

    def preorder(node)
      return if node.nil?

      if block_given?
        yield(node.data)
      else
        puts node.data
        preorder(node.left)
        preorder(node.right)
      end
    end

    def postorder(node)
      return if node.nil?

      if block_given?
        yield(node)
      else
        postorder(node.left)
        postorder(node.right)
        puts node.data
      end
    end

    def height(value, node = @root)
      # number of edges in longest path from given node to leaf node
      return if node.nil?

      if value < node.data
        height(value, node.left)
      elsif value > node.data
        height(value, node.right)
      else
        total_height(node)
      end
    end

    def total_height(node)
      return -1 if node.nil?

      left_height = total_height(node.left)
      right_height = total_height(node.right)
      [left_height, right_height].max + 1
    end

    def depth(value, node = @root, current_depth = 0)
      # number of edges in path from given node to the tree's root
      return if node.nil?

      if value < node.data
        depth(value, node.left, current_depth + 1)
      elsif value > node.data
        depth(value, node.right, current_depth + 1)
      else
        current_depth
      end
    end

    def balanced?(node = @root)
      # check if difference between heights of left subtree and right subtree <= 1
      return true if node.nil?

      left_height = total_height(node.left)
      right_height = total_height(node.right)

      if (left_height - right_height).abs <= 1 &&
      balanced?(node.left) &&
      balanced?(node.right)
        return true
      end

      false
    end

    def rebalance
      # give a traversal method to create a new array
      # give the new array to build_tree
      @root = build_tree(inorder)
    end

    # pre-made pretty print for visualization
    def pretty_print(node = @root, prefix = '', is_left = true)
      return if node.nil?

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
tree.pretty_print
p tree.balanced?
tree.insert(9)
tree.insert(10)
tree.insert(20)
tree.insert(50)
tree.pretty_print
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
tree.pretty_print
#tree.preorder(tree.root)

class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = 
    @right = 6
  end
end

class Tree
  attr_accessor :root
  def initialize
    @root = Node.new(5)
    @root.left = 4
  end
end

test = Tree.new
p test.root.left

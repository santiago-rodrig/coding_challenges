# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end
# @param {TreeNode} root
# @return {Boolean}
def is_symmetric(root)
  return true unless root
  return true if root && (root.left.nil? && root.right.nil?)
  current_level = 1
  completed = false
  status = true
  fetch_level = -> (level) do
    level_nodes = [root]
    current_level = 0
    until current_level == level
      new_level_nodes = []
      level_nodes.each do |n|
        if n
          new_level_nodes << n.left
          new_level_nodes << n.right
        end
      end
      level_nodes = new_level_nodes
      current_level += 1
    end
    level_nodes.map do |n|
      if n
        n.val
      else
        n
      end
    end
  end
  level_is_symmetric = -> (level) do
    middle = level.size / 2
    level[0...middle] == level[middle...level.size].reverse
  end
  until completed
    level = fetch_level.call(current_level)
    if level.none?
      completed = true
      next
    end
    unless level_is_symmetric.call(level)
      status = false
      completed = true
      next
    end
    current_level += 1
  end
  status
end

# tree = TreeNode.new(1)
# tree.left = TreeNode.new(2)
# tree.left.left = TreeNode.new(3)
# tree.left.right = TreeNode.new(4)
# tree.right = TreeNode.new(2)
# tree.right.left = TreeNode.new(4)
# tree.right.right = TreeNode.new(3)

tree = TreeNode.new(1)
tree.left = TreeNode.new(2)
tree.right = TreeNode.new(2)
tree.left.right = TreeNode.new(3)
tree.right.left = TreeNode.new(3)

p is_symmetric(tree)


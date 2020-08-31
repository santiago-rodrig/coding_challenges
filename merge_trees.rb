# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# @param {TreeNode} t1
# @param {TreeNode} t2
# @return {TreeNode}
def merge_trees(t1, t2)
  return if !(t1 || t2)

  t = TreeNode.new

  if t1 && t2
    t.val = t1.val + t2.val
    t.left = merge_trees(t1.left, t2.left)
    t.right = merge_trees(t1.right, t2.right)
  elsif t1 && !t2
    t.val = t1.val
    t.left = merge_trees(t1.left, nil)
    t.right = merge_trees(t1.right, nil)
  elsif !t1 && t2
    t.val = t2.val
    t.left = merge_trees(nil, t2.left)
    t.right = merge_trees(nil, t2.right)
  end

  t
end
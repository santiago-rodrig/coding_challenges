# challenge: https://leetcode.com/problems/same-tree/

# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end
# @param {TreeNode} p
# @param {TreeNode} q
# @return {Boolean}
def is_same_tree(p, q)
  return true if p.nil? && q.nil?
  return false if (p && q.nil?)
  return false if (q && p.nil?)
  return false if (q && p) && (p.val != q.val)

  is_same_tree(p.left, q.left) && is_same_tree(p.right, q.right)
end

# challenge: https://leetcode.com/problems/diameter-of-binary-tree/

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val=0, left=nil, right=nil)
    @val = val
    @left = left
    @right = right
  end
end

# require 'minitest/autorun'

# class DiameterBinaryTreeTest < Minitest::Test
#   def test_simple_tree
#     # set the tree
#     tree = build_tree([1, 2, 3, 4, 5], 0)

#     # compute the results
#     result = diameter_of_binary_tree(tree)
#     expected = 3

#     # make the assertions
#     assert_equal expected, result
#   end

#   def test_convoluted_tree
#     # set the tree
#     tree = build_tree(
#       [
#         4, -7, -3, nil, nil, -9, -3, 9, -7, -4,
#         nil, 6, nil, -6, -6, nil, nil, 0, 6, 5,
#         nil, 9, nil, nil, -1, -4, nil, nil, nil, 2
#       ],
#       0
#     )

#     # compute the results
#     result = diameter_of_binary_tree(tree)
#     expected = 5

#     # make the assertions
#     assert_equal expected, result
#   end

#   private

#   def build_tree(array, i)
#     return if i >= array.size || !array[i]

#     tree = TreeNode.new(array[i])
#     tree.left = build_tree(array, 2 * i + 1)
#     tree.right = build_tree(array, 2 * i + 2)

#     tree
#   end
# end

def diameter_of_binary_tree(root)
  # 1. go as deep as possible to the left
  # 2. go as deep as possible to the right
  # 3. add together

  # if the root is nil return 0
  return 0 unless root

  left_tree = root.left
  right_tree = root.right
  left_depth = 0
  right_depth = 0

  if left_tree
    left_depth += 1
  end

  if right_tree
    right_depth += 1
  end

  get_level_of_tree = -> tree do
    # if the tree is nil return 0
    return 0 unless tree

    left_child = tree.left
    right_child = tree.right
    left_child_depth = 0
    right_child_depth = 0

    if left_child
      left_child_depth = 1 + get_level_of_tree.call(left_child)
    end

    if right_child
      right_child_depth = 1 + get_level_of_tree.call(right_child)
    end

    [left_child_depth, right_child_depth].max
  end

  left_depth += get_level_of_tree.call(left_tree)
  right_depth += get_level_of_tree.call(right_tree)
  puts 'left depth:', left_depth
  puts 'right depth:', right_depth

  left_depth + right_depth
end


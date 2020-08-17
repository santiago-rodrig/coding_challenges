# challenge: https://leetcode.com/problems/move-zeroes/
# Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

# uncomment the code below to perform the tests

# require 'minitest/autorun'

# class MoveZeroesTest < Minitest::Test
#   def test_moves_array_one_zero
#     a = [1, 2, 6, 0, 2, 1]
#     r = move_zeroes(a)
#     e = [1, 2, 6, 2, 1, 0]
#     assert_equal e, r
#   end

#   def test_does_nothing_array_no_zeroes
#     a = [5, 4, 2, 1, 2, 3]
#     r = move_zeroes(a)
#     e = a
#     assert_equal e, r
#   end

#   def test_moves_array_2_zeroes
#     a = [5, 2, 6, 2, 0, 1, 0, 2]
#     r = move_zeroes(a)
#     e = [5, 2, 6, 2, 1, 2, 0, 0]
#     assert_equal e, r
#   end

#   def test_moves_array_2_zeroes_together
#     a = [5, 3, 2, 7, -1, 0, 0, 10, 232]
#     r = move_zeroes(a)
#     e = [5, 3, 2, 7, -1, 10, 232, 0, 0]
#     assert_equal e, r
#   end
# end

# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
  i = 0
  zero_count = 0

  while i < nums.size
    n = nums[i]

    if n.zero?
      zero_count += 1
    else
      nums[i], nums[i - zero_count] = nums[i - zero_count], nums[i]
    end

    i += 1
  end

  nums
end

# if you are using a debugger, then uncomment this code, place some breakpoints
# and start the debugger to see the process

# a = [5, 2, 6, 2, 0, 1, 0, 2]
# r = move_zeroes(a)
# p r

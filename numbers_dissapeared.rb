# challenge: https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/

# Given an array of integers where 1 ≤ a[i] ≤ n (n = size of array),
# some elements appear twice and others appear once.

# Find all the elements of [1, n] inclusive that do not appear in this array.

# Could you do it without extra space and in O(n) runtime? You may assume the
# returned list does not count as extra space.

# here you have some tests

# require 'minitest/autorun'

# class DisspearedNumbersTest < Minitest::Test
#   def test_case_1
#     input = [4, 3, 2, 7, 8, 2, 3, 1]
#     expected = [5, 6]
#     result = find_disappeared_numbers(input)
#     assert_equal expected, result
#   end
# end

# @param {Integer[]} nums
# @return {Integer[]}
def find_disappeared_numbers(nums)
  output = Array.new(nums.size, true)

  nums.each do |n|
    output[n - 1] = nil
  end

  output.map.with_index { |n, i| i + 1 if n }.compact
end

# find_disappeared_numbers([4, 3, 2, 7, 8, 2, 3, 1])

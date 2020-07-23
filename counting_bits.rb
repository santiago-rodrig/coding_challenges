# challenge: https://leetcode.com/problems/counting-bits/

# @param {Integer} num
# @return {Integer[]}
def count_bits(num)
  # num is nonnegative
  (0..num).to_a.map { |n| n.to_s(2).count('1') }
end

# test case 1
input = 2
output = count_bits(input)
p output # => [0, 1, 1]

# test case 2
input = 5
output = count_bits(input)
p output # => [0, 1, 1, 2, 1, 2]


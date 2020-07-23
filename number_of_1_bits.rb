# challenge: https://leetcode.com/problems/number-of-1-bits/

# @param {Integer} n, a positive integer
# @return {Integer}
def hamming_weight(n)
  # n is a nonnegative integer
  n.to_s(2).count('1')
end

# test case 1
input = 0b1011
output = hamming_weight(input)
p output # => 3

# test case 2
input = 0b10000000
output = hamming_weight(input)
p output # => 1

# test case 3
input = 0b11111111111111111111111111111101
output = hamming_weight(input)
p output # => 31


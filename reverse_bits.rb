# challenge: https://leetcode.com/problems/reverse-bits/

# @param {Integer} n, a positive integer
# @return {Integer}
def reverse_bits(n)
  # n is a nonnegative integer (32 bits)
  # 00000010100101000001111010011100
  # 00111001011110000010100101000000
  n.to_s(2).rjust(32, '0').reverse.to_i(2)
end

# test case 1
input = 0b00000010100101000001111010011100
output = reverse_bits(input)
p output # => 0b00111001011110000010100101000000 or 964176192

# test case 2
input = 0b11111111111111111111111111111101
output = reverse_bits(input)
p output # => 0b10111111111111111111111111111111 or 3221225471


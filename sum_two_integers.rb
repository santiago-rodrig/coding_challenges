# challenge: https://leetcode.com/problems/sum-of-two-integers/

# @param {Integer} a
# @param {Integer} b
# @return {Integer}
def get_sum(a, b)
  a_bin = a.abs.to_s(2).rjust(31, '0')
  b_bin = b.abs.to_s(2).rjust(31, '0')
  if a.negative?
    a_bin = '1' + a_bin
  else
    a_bin = '0' + a_bin
  end
  if b.negative?
    b_bin = '1' + b_bin
  else
    b_bin = '0' + b_bin
  end
end


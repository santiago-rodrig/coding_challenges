# challenge: https://leetcode.com/problems/missing-number/
# @param {Integer[]} nums
# @return {Integer}
def missing_number(nums)
  # from 0 to n
  # the input is not ordered
  # all of them are integers
  # how this relates to binary?
  result = nums.length
  nums.each_with_index do |n, i|
    result ^= i ^ n
  end
  result
end

# Another solution that is easily understandable is the following.
# The formula comes from sum of sequences, the sum of the numbers
# starting from zero until n

def missing_number(nums)
  count = 1
  sum = nums[0]
  nums[1...nums.size].each do |n|
    count += 1
    sum += n
  end
  ((count * (count + 1)) / 2) - sum
end


# challenge: https://leetcode.com/problems/house-robber/

# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  if nums.empty?
    return 0
  elsif nums.size == 1
    return nums[0]
  end

  parsed_sum = []
  parsed_sum << nums[0]
  parsed_sum << [nums[0], nums[1]].max

  (2...nums.size).each do |i|
    parsed_sum << [parsed_sum[-1], parsed_sum[-2] + nums[i]].max
  end

  parsed_sum[-1]
end


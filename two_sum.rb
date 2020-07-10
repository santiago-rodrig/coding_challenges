# https://leetcode.com/problems/two-sum

def two_sum(nums, target)
  num_indices = {}
  nums.each_with_index do |num, idx|
    complement = target - num
    if num_indices.has_key?(complement)
      return [num_indices[complement], idx]
    end
    num_indices[num] = idx
  end
end

# puts two_sum([-3,4,3,90], 0)
# => [0, 2]

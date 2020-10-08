# challenge: https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def search_range(nums, target)
  target_index = nums.bsearch_index { |num| target <=> num }

  return [-1, -1] unless target_index

  i = target_index

  while nums[i] == target && !i.negative?
    i -= 1
  end

  i += 1

  j = target_index

  while nums[j] == target
    j += 1
  end

  j -= 1

  [i, j]
end

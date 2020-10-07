# challenge: https://leetcode.com/problems/search-in-rotated-sorted-array/

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  sub_array_start = -1
  target_index = -1

  nums.each_with_index do |num, i|
    next_num = nums[i + 1]

    if next_num && next_num < num
      sub_array_start = i + 1

      break
    end
  end

  if sub_array_start == -1
    target_index = nums.bsearch_index { |num| target <=> num }
  else
    left_half = nums[0...sub_array_start]
    right_half = nums[sub_array_start...nums.size]
    target_index = left_half.bsearch_index { |num| target <=> num }

    unless target_index
      target_index = right_half.bsearch_index { |num| target <=> num }

      if target_index
        target_index += left_half.size
      end
    end
  end

  target_index || -1
end

search([4,5,6,7,0,1,2], 0)
# challenge: https://leetcode.com/problems/majority-element/

# nums is an array of integers
# 1. It is not empty
# 2. There is always a majority element
def majority_elements(nums)
  threshold = nums.size / 2
  counts = Hash.new(0)

  nums.each do |n|
    counts[n] += 1
    if counts[n] > threshold
      return n
    end
  end
end


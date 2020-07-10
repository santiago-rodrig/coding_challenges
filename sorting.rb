module Sorting
  def self.quicksort(nums, start=0, finish=(nums.size)-1)
    return if finish <= start
    left, right = nil, nil
    (start...finish).each do |i|
      if nums[i] <= nums[finish]
        if right
          nums[right], nums[i] = nums[i], nums[right]
          left = right
          right += 1
        else
          left = i
        end
      elsif nums[i] > nums[finish]
        right = i unless right
      end
    end
    if right
      nums[finish], nums[right] = nums[right], nums[finish]
      quicksort(nums, right+1, finish)
    end
    quicksort(nums, start, left) if left

    nil
  end
end

module Searching
  def self.binary_search(nums, target, start=0, finish=nums.size-1)
    return if finish < start
    middle = start + ((finish - start) / 2)
    if nums[middle] == target
      return middle
    elsif nums[middle] < target
      return binary_search(nums, target, middle+1, finish)
    else
      return binary_search(nums, target, start, middle-1)
    end

    nil
  end
end

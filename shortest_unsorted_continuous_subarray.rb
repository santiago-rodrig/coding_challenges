# challenge: https://leetcode.com/problems/shortest-unsorted-continuous-subarray/

# @param {Integer[]} nums
# @return {Integer}
def find_unsorted_subarray(nums)
  # from the left
  left = nil
  i = 0

  loop do
    current = nums[i]
    next_one = nums[i + 1]

    return 0 unless next_one

    if current > next_one
      left = i

      break
    else
      i += 1
    end
  end

  # from the right
  right = nil
  i = -1

  loop do
    current = nums[i]
    previous_one = nums[i - 1]

    if current < previous_one
      right = nums.size + i

      break
    else
      i -= 1
    end
  end

  # set the subarray
  sub_array = nums[left..right]
  # find the maximum in the subarray
  maximum = sub_array.max
  # find the minimum in the subarray
  minimum = sub_array.min
  # now iterate to the right of the right index
  i = right + 1

  loop do
    current = nums[i]

    if current && current >= maximum
      right = i - 1

      break
    elsif !current
      right = nums.size - 1

      break
    else
      i += 1
    end
  end

  # now iterate to the left of the left index
  i = left - 1

  loop do
    current = nums[i]

    if !i.negative? && current <= minimum
      left = i + 1

      break
    elsif i.negative?
      left = 0

      break
    else
      i -= 1
    end
  end

  right - left + 1
end

find_unsorted_subarray([5,16,6,15,4,13,3,8,9,14,17,10,7,0,11,1,2,12,18,19,20,21,22,23,24])

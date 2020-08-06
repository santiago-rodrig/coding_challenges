#challenge: https://leetcode.com/problems/single-number/

# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)
  return nums.first if nums.size == 1
  duplicates_check_hash = Hash.new
  nums.each do |n|
    if duplicates_check_hash.has_key?(n)
      duplicates_check_hash.delete(n)
    else
      duplicates_check_hash[n] = true
    end
  end
  duplicates_check_hash.keys.first
end

# p single_number([2, 2, 1])
# p single_number([4, 1, 2, 1, 2])

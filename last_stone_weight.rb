# challenge: https://leetcode.com/problems/last-stone-weight/

# @param {Integer[]} stones
# @return {Integer}
def last_stone_weight(stones)
  return stones[0] if stones.size == 1
  return 0 if stones.empty?
  max1_idx = stones.find_index(stones.max)
  max1 = stones[max1_idx]
  stones[max1_idx] = nil
  stones.reject! { |n| n.nil? }
  max2_idx = stones.find_index(stones.max)
  max2 = stones[max2_idx]
  stones[max2_idx] = nil
  stones.reject! { |n| n.nil? }
  difference = max1 - max2
  unless difference.zero?
    stones << difference
  end
  last_stone_weight(stones)
end

# https://leetcode.com/problems/3sum/
require 'set'

def three_sum(nums)
  triplets = Set[]
  positives, negatives, zeroes = [], [], []
  nums.each do |n|
    case
    when n > 0
      positives << n
    when n < 0
      negatives << n
    when n == 0
      zeroes << n
    end
  end
  if zeroes.size >= 3
    triplets.add([0, 0, 0])
  end
  n_set, p_set = Set.new(negatives), Set.new(positives)
  positives.each_with_index do |a, i|
    positives[(i + 1)...positives.size].each do |b|
      a_b = a + b
      if n_set.include?(-a_b)
        triplets.add([a, b, -a_b].sort)
      end
    end
  end
  negatives.each_with_index do |a, i|
    if p_set.include?(-a) && !zeroes.empty?
      triplets.add([a, 0, -a])
    end
    negatives[(i + 1)...negatives.size].each do |b|
      a_b = a + b
      if p_set.include?(-a_b)
        triplets.add([a, b, -a_b].sort)
      end
    end
  end
  triplets.to_a
end

# p three_sum([-1, 0, 1, 2, -1, -4])
# => [[-1, 0, 1], [-1, -1, 2]]

# p three_sum([0, 0, 1, 2, 3, 4])
# => []

# p three_sum([0, 0, 0, 3, 4, 5, 7])
# => [[0, 0, 0]]

# p three_sum([1, 1, -2])
# => [[-2, 1, 1]]

# p three_sum([2,-3,0,-2,-5,-5,-4,1,2,-2,2,0,2,-4])
# => [[-4, 2, 2], [-3, 1, 2], [-2, 0, 2]]

# p three_sum([6,-5,-6,-1,-2,8,-1,4,-10,-8,-10,-2,-4,-1,-8,-2,8,9,-5,-2,-8,-9,-3,-5])
# => [[-10,4,6],[-8,-1,9],[-6,-3,9],[-6,-2,8],[-5,-4,9],[-5,-3,8],[-5,-1,6],[-4,-2,6],[-3,-1,4],[-2,-2,4]]

# p three_sum([-10,-3,-8,-3,4,-1,-2,-4,-8,-5])
# => [[-3,-1,4]]

# challenge: https://leetcode.com/problems/container-with-most-water/

# @param {Integer[]} height
# @return {Integer}
def max_area(height)
  # area between two towers
  i = 0
  j = height.length - 1
  maximum = nil
  
  area = -> () do
    (j - i) * [height[i], height[j]].min
  end
  
  while i < j
    calculated_area = area.call
    maximum = !maximum || maximum < calculated_area ? calculated_area : maximum
    height_left = height[i]
    height_right = height[j]
    
    if height_left < height_right
      i += 1
    else
      j -= 1
    end
  end
  
  maximum
end

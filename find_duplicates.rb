def duplicates(arr1, arr2)
  # write your code here
  while arr1.size > 0
    pos = arr2.find_index(arr1[0])
    if pos
      arr1.shift
      arr2.delete_at(pos)
    end
  end
  arr2.sort
end

p duplicates([203, 204, 205, 206, 207, 208, 203, 204, 205, 206], [203, 204, 204, 205, 206, 207, 205, 208, 203, 206, 204, 205, 206])
# => [204, 205, 206]
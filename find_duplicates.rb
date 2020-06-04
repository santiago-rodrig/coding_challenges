# finds the remainder after removing the duplicates between two collections
def duplicates(arr1, arr2)
  # arr1: Array with integers, duplicate of a subset of arr2
  # arr2: Array with integers

  # While arr1 has at least 1 element
  while arr1.size > 0
    # in arr2 find the index of the element that matches the first element
    # in arr1
    pos = arr2.find_index(arr1[0])
    # if there is such an element, delete from the beginning of arr1 and
    # delete that element in arr2 at the fetched position
    if pos
      arr1.shift
      arr2.delete_at(pos)
    end
  end
  # return the remainder of elements in arr2 sorted in ascending order
  arr2.sort
end

p duplicates([203, 204, 205, 206, 207, 208, 203, 204, 205, 206], [203, 204, 204, 205, 206, 207, 205, 208, 203, 206, 204, 205, 206])
# => [204, 205, 206]

# return the median of an array of integers
# without sorting the array
def median(array)
  # mutate the array until the median is right in the
  # middle
  partition(array)
  # return the middle element of the array,
  # aka the median
  array[array.size / 2]
end

# quicksort algorithm until the median is found
def partition(array, start_index = 0, finish_index = (array.size - 1))
  # if there is no subarray to sort, return
  return if start_index >= finish_index

  # choose the pivot to be the last element of the array
  pivot = array[finish_index]
  # left and right are going to be indices,
  # left for the element at the left of the pivot,
  # and right for the element at the right of the
  # pivot by the moment the pivot is placed where it should be
  left, right = nil, nil

  # iterate from the start index to the finish index
  (start_index...finish_index).each do |i|
    # if the element is less than the pivot value
    if array[i] < pivot
      # if there is a right index
      if right
        # swap the elements at the right index and the
        # current index
        array[right], array[i] = array[i], array[right]
        # the left index is now the right index
        left = right
        # the right index is the next element after itself
        right += 1
      else
        # if there is no right index, left is going to be the
        # current index
        left = i
      end
    else
      # if the element's value is greater than or equal to
      # the pivot's value
      if !right
        # if there is no right index, the right index is
        # the current index
        right = i
      end
    end
  end
  # if there is a right index, swap the pivot with the element at the
  # right index
  array[finish_index], array[right] = array[right], array[finish_index] if right
  # if the median was found, return
  return if array[0...(array.size / 2)].all? {|n| n < array[array.size / 2]}
  # partition the from the start index to the left index if there is a left
  # index
  partition(array, start_index, left) if left
  # partition from right's next index to the finish index if there is a right
  # index
  partition(array, right + 1, finish_index) if right
end

# puts median([0, 0, 1, 2, 5, 4, 3, 3, 3])
puts median([0, 0, 0, 0, 0, 0, 0, 0, 0])

# applies merge sort to two given arrays
def merge_sort(array1, array2)
  # the final result
  sorted = []
  # the amount of items to sort
  number_of_items = array1.size + array2.size
  # this variable will hold the next item
  # to be pushed to the sorted result
  item_to_add = nil

  # iterate over the total of items
  number_of_items.times do
    # if the first array and the second array
    # have an element at the very beginning
    if array1.first && array2.first
      # if the element at the beginning of the
      # first array is greater than the first
      # element of the second array
      if array1.first > array2.first
        # the item to be added is going to be the first
        # element of the second array and the first element
        # of the second array will be pulled out
        item_to_add = array2.shift
      # if instead the first element of the first array
      # is less than or equal to the first element
      # of the second array
      elsif array1.first <= array2.first
        # the item to add is going to be the first
        # element of the first array, and the first
        # array's first element will be pulled out
        item_to_add = array1.shift
      end
    # if the first array has no elements but the second
    # array do has a first element
    elsif array1.first.nil? && array2.first
      # the item to add is going to be the first
      # element of the second array
      item_to_add = array2.shift
    # if the second array has no elements but the first
    # array do has a first element
    elsif array2.first.nil? && array1.first
      # the item to add is going to be the first
      # element of the first array, and the first
      # array's first element will be pulled out
      item_to_add = array1.shift
    end

    # push the item to add to the sorted result
    sorted.push(item_to_add)
  end

  # return sorted
  sorted
end

p merge_sort([1, 3, 9, 11], [2, 4, 6, 8])
# => [1, 2, 3, 4, 6, 8, 9, 11]

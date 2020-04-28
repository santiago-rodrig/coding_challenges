def merge_sort(array1, array2)
  sorted = []
  number_of_items = array1.size + array2.size
  item_to_add = nil

  number_of_items.times do
    if array1.first && array2.first
      if array1.first > array2.first
        item_to_add = array2.shift
      elsif array1.first <= array2.first
        item_to_add = array1.shift
      end
    elsif array1.first.nil? && array2.first
      item_to_add = array2.shift
    elsif array2.first.nil? && array1.first
      item_to_add = array1.shift
    end

    sorted.push(item_to_add)
  end

  sorted
end

p merge_sort([1, 3, 9, 11], [2, 4, 6, 8])
# => [1, 2, 3, 4, 6, 8, 9, 11]

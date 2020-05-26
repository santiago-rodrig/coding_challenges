def median(array)
  partition(array)
  array[array.size / 2]
end

def partition(array, start_index = 0, finish_index = (array.size - 1))
  return if start_index >= finish_index

  pivot = array[finish_index]
  left, right = nil, nil

  (start_index...finish_index).each do |i|
    if array[i] < pivot
      if right
        array[right], array[i] = array[i], array[right]
        left = right
        right += 1
      else
        left = i
      end
    else
      if !right
        right = i
      end
    end
  end
  array[finish_index], array[right] = array[right], array[finish_index] if right
  return if array[0...(array.size / 2)].all? {|n| n < array[array.size / 2]}
  partition(array, start_index, left) if left
  partition(array, right + 1, finish_index) if right
end

# puts median([0, 0, 1, 2, 5, 4, 3, 3, 3])
puts median([0, 0, 0, 0, 0, 0, 0, 0, 0])

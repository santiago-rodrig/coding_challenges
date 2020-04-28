# this is the insertion sort algorithm
# 1. the first element is 'sorted'
# 2. you check the next element
# 2.1. if it is greater than its previous element, do nothing
# 2.2. if the previous element is greater, swap
# 3. repeat 2
def insertion_sort(array)
  (1...array.size).each do |i|
    j, k = i - 1, i

    until array[j] < array[k]
      array[j], array[k] = array[k], array[j]
      j -= 1
      k -= 1
      $insertion_shifts += 1
      break if j.negative?
    end
  end
end

# this is the quick sort algorithm
# 1. the 'pivot' is the last element
# 2. start checking from the beginning of the collection
# 3. if the element being checked is smaller than the pivot, swap with left
# 4. repeat until you have reached all elements but the pivot
# 5. swap the pivot with left
# 6. repeat with the left remainder and the right remainder
def quick_sort(array, start=0, finish=(array.size - 1))
  if start < finish
    pivot = partition(array, start, finish)
    quick_sort(array, start, pivot - 1)
    quick_sort(array, pivot + 1, finish)
  end
end

def partition(array, start, finish)
  pivot = array[finish]
  left = start

  (start...finish).each do |i|
    if array[i] <= pivot
      array[i], array[left] = array[left], array[i]
      left += 1
      $quick_swaps += 1
    end
  end

  array[finish], array[left] = array[left], array[finish]
  $quick_swaps += 1
  left
end

def quicksort_running_time(array)
  $insertion_shifts, $quick_swaps = 0, 0
  insertion_sort(array.clone)
  quick_sort(array.clone)
  $insertion_shifts - $quick_swaps
end

# puts quicksort_running_time([1, 3, 9, 8, 2, 7, 5])
# => 1
puts quicksort_running_time([10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
# => 16

def index_match(array)
	# where array[i] == i?
  array[0, array.size].each_with_index do |number, index|
    return index if number == index
  end

  -1
end

puts index_match([0, 2, 3, 7, 9, 11])
# => 0

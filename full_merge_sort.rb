class MergeSortCollection
  # receives an array, by default it is nor sorted
  def initialize(array, sorted=false)
    @collection = array
    @sorted = sorted
    # get its median
    median = @collection.size / 2
    # divide the array in two parts
    @left_half = @collection[0...median]
    @right_half = @collection[median...@collection.size]
  end

  # sorts the collection in place
  def sort!
    # return if the collection is sorted
    return if @sorted

    # after the procedure, the collection is sorted
    @sorted = true

    # it is the same collection if the collection
    # only has one element
    if @collection.size == 1
      return self
    else
      # the left half sorted and as an array
      @left_half = MergeSortCollection.new(@left_half).sort!.to_a
      # the right half sorted and as an array
      @right_half = MergeSortCollection.new(@right_half).sort!.to_a
      # merge the two sorted halves
      @collection = merge(@left_half, @right_half)
    end

    # return the collection itself
    self
  end

  def to_a
    # returns the collection
    @collection
  end

  private

  # merge sort algorithm
  def merge(left_half, right_half)
    sorted = []
    number_of_items = left_half.size + right_half.size
    item_to_add = nil

    number_of_items.times do
      if left_half.first && right_half.first
        left_compare = left_half.first.match(/\A(\d+)\s(.+)\Z/)[1].to_i
        right_compare = right_half.first.match(/\A(\d+)\s(.+)\Z/)[1].to_i
        if left_compare > right_compare
          item_to_add = right_half.shift
        elsif left_compare <= right_compare
          item_to_add = left_half.shift
        end
      elsif left_half.first.nil? && right_half.first
        item_to_add = right_half.shift
      elsif right_half.first.nil? && left_half.first
        item_to_add = left_half.shift
      end

      sorted.push(item_to_add)
    end

    sorted
  end
end

# sorts an array by number
def full_merge_sort(array)
  MergeSortCollection.new(array).sort!.to_a.map do |data|
    # fetch the letters, not the numbers
    data.match(/\A(\d+)\s(.+)\Z/)[2]
  end
end

p full_merge_sort([
  "0 ab",
  "6 cd",
  "0 ef",
  "6 gh",
  "4 ij",
  "0 ab",
  "6 cd",
  "0 ef",
  "6 gh",
  "0 ij",
  "4 that",
  "3 be",
  "0 to",
  "1 be",
  "5 question",
  "1 or",
  "2 not",
  "4 is",
  "2 to",
  "4 the"
])

# => [
# "ab",
# "ef",
# "ab",
# "ef",
# "ij",
# "to",
# "be",
# "or",
# "not",
# "to",
# "be",
# "ij",
# "that",
# "is",
# "the",
# "question",
# "cd",
# "gh",
# "cd",
# "gh"
# ]

class MergeSortCollection
  def initialize(array, sorted=false)
    @collection = array
    @sorted = sorted
    median = @collection.size / 2
    @left_half = @collection[0...median]
    @right_half = @collection[median...@collection.size]
    # creating the collection
  end

  def sort!
    # sorting the collection
    return if @sorted

    @sorted = true

    if @collection.size == 1
      return self
    else
      @left_half = MergeSortCollection.new(@left_half).sort!.to_a
      @right_half = MergeSortCollection.new(@right_half).sort!.to_a
      @collection = merge(@left_half, @right_half)
      # change the @collection to be sorted
    end

    self
  end

  def to_a
    @collection
  end

  private

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

def full_merge_sort(array)
  MergeSortCollection.new(array).sort!.to_a.map do |data|
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

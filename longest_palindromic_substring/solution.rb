# challenge: https://leetcode.com/problems/longest-palindromic-substring/

class Palindrome
  attr_reader :positions

  def self.define_source(str)
    @@source = str
  end

  def initialize(data, positions)
    set_positions(positions)
    @data = data.split('')
    @offset = 1
    @parsed = false
  end

  def length
    @data.length
  end

  def to_s
    @data.join('')
  end

  def push
    unless is_pushable?
      @parsed = true

      return false
    end

    if is_single?
      @data.unshift(@@source[(positions[:left] - @offset)])
      @data.push(@@source[(positions[:left] + @offset)])
    else
      @data.unshift(@@source[(positions[:left] - @offset)])
      @data.push(@@source[(positions[:right] + @offset)])
    end

    @offset += 1

    true
  end

  def parsed?
    @parsed
  end

  private

  def is_pushable?
    if is_single?
      left_data_idx = (positions[:left] - @offset)

      return false if left_data_idx.negative?

      right_data_idx = (positions[:left] + @offset)
      left_data = @@source[left_data_idx]
      right_data = @@source[right_data_idx]

      return false if left_data != right_data
    else
      left_data_idx = (positions[:left] - @offset)

      return false if left_data_idx.negative?

      right_data_idx = (positions[:right] + @offset)
      left_data = @@source[left_data_idx]
      right_data = @@source[right_data_idx]

      return false if left_data != right_data
    end

    true
  end

  def is_single?
    @positions[:right].nil?
  end

  def set_positions(positions)
    @positions = {
      left: positions[0],
      right: positions[1]
    }
  end
end

# @param {String} s
# @return {String}
def longest_palindrome(s)
  Palindrome.define_source(s)
  palindromes = []
  double_palindromes = []

  (0...s.length).each do |i|
    current = s[i]
    palindromes << Palindrome.new(current, [i])
    next_one = s[i + 1]

    if current == next_one
      double_palindromes << Palindrome.new((current + next_one), [i, (i + 1)])
    end

    i += 1
  end

  palindromes += double_palindromes
  parsing = palindromes.clone
  parsed = []

  loop do
    to_delete = []

    parsing.each_with_index do |palindrome, i|
      pushed = palindrome.push

      if !pushed
        parsed << palindrome
        to_delete << i
      end
    end

    to_delete.each do |i|
      parsing[i] = nil
    end

    parsing.compact!

    break if parsing.empty?
  end

  parsed.last.to_s
end

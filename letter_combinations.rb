# challenge: https://leetcode.com/problems/letter-combinations-of-a-phone-number/

# Given a string containing digits from 2-9 inclusive, return all possible
# letter combinations that the number could represent.

# A mapping of digit to letters (just like on the telephone buttons) is given
# below. Note that 1 does not map to any letters.

# @param {String} digits
# @return {String[]}
def letter_combinations(digits)
  return [] if digits.empty?

  letters_map = {
    '2' => ['a', 'b', 'c'],
    '3' => ['d', 'e', 'f'],
    '4' => ['g', 'h', 'i'],
    '5' => ['j', 'k', 'l'],
    '6' => ['m', 'n', 'o'],
    '7' => ['p', 'q', 'r', 's'],
    '8' => ['t', 'u', 'v'],
    '9' => ['w', 'x', 'y', 'z']
  }

  positions = digits.split('').map.with_index do |digit, i|
    [i, digit]
  end.to_h

  valid_combination = lambda do |combo|
    combo.split('').each_with_index do |letter, i|
      is_included = letters_map[positions[i]].include?(letter)
      return false unless is_included
    end

    true
  end

  return digits.split('').reduce([]) do |result, digit|
    result + letters_map[digit]
  end.combination(digits.size).to_a.map do |combo|
    combo.join('')
  end.uniq.delete_if do |combo|
    !valid_combination.call(combo)
  end.sort
end

p letter_combinations('22')

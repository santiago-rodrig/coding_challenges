# challenge: https://leetcode.com/problems/longest-substring-without-repeating-characters/

# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  return s.length if s.length <= 1

  i = 0
  j = 1
  substr = s[i]
  repeated_idx = substr.index(s[j])
  maximum = -1
  behind = ''

  loop do
    if repeated_idx
      maximum = [maximum, substr.length].max
      i = behind.length + repeated_idx + 1
      substr = substr[(repeated_idx + 1)...substr.size] || ''
      substr += s[j]
      j += 1
      behind = s[0...i]
    else
      substr += s[j]
      j += 1
    end

    repeated_idx = substr.index(s[j]) if s[j]

    break if j >= s.length
  end

  maximum = [maximum, substr.length].max

  maximum
end

puts length_of_longest_substring('abcabcbb')
puts length_of_longest_substring('bbbbb')
puts length_of_longest_substring('pwwkew')


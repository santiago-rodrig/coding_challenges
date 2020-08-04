# challenge: https://leetcode.com/problems/valid-anagram/

# @param {String} s
# @param {String} t
# @return {Boolean}
def is_anagram(s, t)
  return false if s.length != t.length
  h1 = Hash.new(0)
  h2 = Hash.new(0)
  (0...s.length).each do |i|
    h1[s[i]] += 1
    h2[t[i]] += 1
  end
  h1.each do |k, v|
    return false if h2[k] != v
  end
  true
end

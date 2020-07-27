# challenge: https://leetcode.com/problems/count-primes/

# @param {Integer} n
# @return {Integer}
require 'set'
def count_primes(n)
  return 0 if n <= 2
  primes = Array.new(n, true)
  (2...n).each do |i|
    if primes[i]
      j = i * i
      while j < n
        primes[j] = false
        j += i
      end
    end
  end
  primes[2...primes.size].count { |p| p }
end

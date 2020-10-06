# challenge: https://leetcode.com/problems/generate-parentheses/

# @param {Integer} n
# @return {String[]}
def generate_parenthesis(n)
  # n is the number of pairs of parenthesis
  output = []

  backtrack = -> (str = '', left = 0, right = 0) do
    if str.length == n * 2
      output << str
      return
    end

    if left < n
      backtrack.call(str + '(', left + 1, right)
    end

    if right < left
      backtrack.call(str + ')', left, right + 1)
    end
  end

  backtrack.call

  output
end

p generate_parenthesis(4)

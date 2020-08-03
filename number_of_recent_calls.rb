# challenge: https://leetcode.com/problems/number-of-recent-calls/submissions/

class RecentCounter
  def initialize()
    @pings = []
  end

=begin
  :type t: Integer
  :rtype: Integer
=end
  def ping(t)
    counter = 1
    @pings << t
    if @pings.size >= 2
      i = -2
      while @pings[i]
        unless @pings[i] < t - 3000
          counter += 1
          i -= 1
        else
          break
        end
      end
    end
    counter
  end
end

# Your RecentCounter object will be instantiated and called as such:
# obj = RecentCounter.new()
# param_1 = obj.ping(t)
# obj.ping()

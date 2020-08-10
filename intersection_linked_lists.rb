# challenge: https://leetcode.com/problems/intersection-of-two-linked-lists/

class ListNode
  attr_accessor :val, :next

  def initialize(val=nil)
    @val = val
    @next = nil
  end

  def to_s
    str = []
    node = self
    while node
      str << "(#{node.val})"
      node = node.next
    end
    str.join('->')
  end
end

# headA and headB are the heads of two different linked lists
def getIntersectionNode(headA, headB)
  visited = {}
  p_a = headA
  p_b = headB

  while p_a || p_b
    if p_a && visited.has_key?(p_a)
      return p_a
    elsif p_a
      visited[p_a] = true
    end

    if p_b && visited.has_key?(p_b)
      return p_b
    elsif p_b
      visited[p_b] = true
    end

    p_a = p_a.next if p_a
    p_b = p_b.next if p_b
  end

  nil
end


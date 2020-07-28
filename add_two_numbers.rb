# challenge: https://leetcode.com/problems/add-two-numbers/

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end

  def to_s
    current = self
    str = []
    while current
      str << current.val
      current = current.next
    end
    str.join('->')
  end
end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  l3 = nil
  p3 = nil
  p1 = l1
  p2 = l2
  add_one = false
  parse_addition = -> (v1, v2) do
    addition = v1 + v2
    addition += 1 if add_one
    add_one = addition > 9 ? true : false
    (add_one && addition % 10) || addition
  end
  until [p1, p2].none?
    if l3
      if p1 && p2
        p3.next = ListNode.new(parse_addition.call(p1.val, p2.val))
      elsif p1 && !p2
        p3.next = ListNode.new(parse_addition.call(p1.val, 0))
      elsif p2 && !p1
        p3.next = ListNode.new(parse_addition.call(p2.val, 0))
      end
      p3 = p3.next
    else
      l3 = ListNode.new(parse_addition.call(p1.val, p2.val))
      p3 = l3
    end
    p1 = p1.next if p1
    p2 = p2.next if p2
  end
  if add_one
    p3.next = ListNode.new(1)
  end
  l3
end

l1 = ListNode.new(9)
l1.next = ListNode.new(8)
l2 = ListNode.new(1)

add_two_numbers(l1, l2)

require 'pry'
# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end

  def to_s
    str = self.val.to_s
    p = self
    until p.next.nil?
      str += p.val.to_s
      p = p.next
    end
    str.split('').join('->')
  end
end
# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def merge_two_lists(l1, l2)
  p = l2
  
  iterate_and_insert = lambda do |node|
    n = l1

    binding.pry
    if n.nil? || n.val >= node.val
      node.next = n
      l1 = node
      binding.pry
    else
      is_insertable = -> () do
        insertable = n.val <= node.val && (n.next && n.next.val >= node.val)
        at_last = n.val <= node.val && n.next.nil?
        insertable || at_last
      end

      until is_insertable.call
        n = n.next
      end
      
      node.next = n.next
      n.next = node
    end
  end
  
  until p.nil?
    p_next = p.next
    iterate_and_insert.call(p)
    p = p_next
  end
  
  l1
end

l1 = nil
l2 = ListNode.new

puts merge_two_lists(l1, l2)

# challenge: https://leetcode.com/problems/remove-nth-node-from-end-of-list/

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end

  def to_s
    node = self
    str = []

    while node
      str << node.val.to_s
      node = node.next
    end

    str.join('->')
  end
end

# @param {ListNode} head
# @param {Integer} n
# @return {ListNode}
def remove_nth_from_end(head, n)
  return nil unless head && head.next

  node = head
  found = false
  result = nil

  until found
    counter = 0
    chain_link = nil

    n.times do
      chain_link = chain_link.nil? ? node.next : chain_link.next

      break unless chain_link

      counter += 1
    end

    if !chain_link && counter == n - 1
      result = head.next
      found = true
    elsif chain_link.next
      node = node.next
    elsif !chain_link.next && counter == n
      node.next = node.next.next
      result = head
      found = true
    end
  end

  result
end

list                     = ListNode.new(1)
list.next                = ListNode.new(2)
list.next.next           = ListNode.new(3)
list.next.next.next      = ListNode.new(4)
list.next.next.next.next = ListNode.new(5)

puts 'LIST BEFORE:', list

list_after = remove_nth_from_end(list, 2)

puts 'LIST AFTER:', list_after


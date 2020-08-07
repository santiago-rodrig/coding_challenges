# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val)
    @val = val
    @next = nil
  end
end

# @param {ListNode} head
# @return {Boolean}
def hasCycle(head)
  visited = {}
  node = head

  while node
    if visited.has_key?(node)
      return true
    else
      visited[node] = true
    end

    node = node.next
  end

  false
end
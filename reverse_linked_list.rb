# challenge: https://leetcode.com/problems/reverse-linked-list/

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode} head
# @return {ListNode}
def reverse_list(head)
  # cache the nodes in reverse order but in an array
  reversed_list_nodes = []
  node = head
  while node
    reversed_list_nodes << node
    node = node.next
  end
  reversed_list_nodes.reverse!
  ###
  # re-map the nodes next node to be the one that follows in the inversed array
  (0...reversed_list_nodes.size).each do |i|
    n_a = reversed_list_nodes[i]
    n_b = reversed_list_nodes[i + 1]
    n_a.next = n_b
  end
  # return the new head
  reversed_list_nodes.first
end

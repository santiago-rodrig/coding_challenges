# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end
# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)
  buffer = []

  lists.each do |list|
    while list
      buffer << list.val
      list = list.next
    end
  end

  return [] if buffer.empty?

  buffer.sort!
  merged_list = ListNode.new
  node = merged_list

  buffer.each_with_index do |val, i|
    node.val = val

    if i < buffer.size - 1
      node.next = ListNode.new
      node = node.next
    end
  end

  merged_list
end

merge_k_lists([])
# Definition for a Node.
class Node
  attr_accessor :val, :neighbors
  def initialize(val = 0, neighbors = nil)
    @val = val
    neighbors = [] if neighbors.nil?
    @neighbors = neighbors
  end

  def mapped_n
    neighbors.map(&:val).inspect
  end

  def to_s
    lines = []
    visited_nodes = []
    def traverse_and_print(to_visit_nodes, visited_nodes, lines)
      all_visited = lambda do |list|
        result = list.all? do |n0|
          visited_nodes.include?(n0)
        end
        result
      end
      if all_visited.call(to_visit_nodes)
        return
      end
      to_visit_nodes.each do |n|
        unless visited_nodes.include?(n)
          line = "#{n.val} -> #{n.neighbors.map(&:val).inspect}"
          lines << line
          visited_nodes << n
          if all_visited.call(n.neighbors)
            return
          else
            traverse_and_print(n.neighbors, visited_nodes, lines)
          end
        end
      end
    end
    line = "#{val} -> #{neighbors.map(&:val).inspect}"
    lines << line
    visited_nodes << self
    traverse_and_print(neighbors, visited_nodes, lines)
    lines.join("\n").chomp
  end
end

# @param {Node} node
# @return {Node}
def cloneGraph(node)
  return nil unless node
  def populate(original, copy, skipped_nodes, skipped_copies)
    original.neighbors.each do |n|
      if skipped_nodes.include?(n)
        neighbor = skipped_copies.find_index do |member|
          member.val == n.val
        end
        neighbor = skipped_copies[neighbor]
        copy.neighbors << neighbor
      else
        other_copy = Node.new(n.val)
        copy.neighbors << other_copy
        skipped_copies << other_copy
        skipped_nodes << n
        populate(n, other_copy, skipped_nodes, skipped_copies)
      end
    end
  end
  node_copy = Node.new(node.val)
  populate(node, node_copy, [node], [node_copy])
  node_copy
end

# test case 1

node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)

node1.neighbors.push(node2, node4)
node2.neighbors.push(node1, node3)
node3.neighbors.push(node2, node4)
node4.neighbors.push(node1, node3)

output = cloneGraph(node1)


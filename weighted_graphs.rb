class Node
  # 1. A Node has a collection of Nodes that are connected to itself
  # 2. The connections are represented as a pair: [Node, distance]

  attr_reader :value, :connections

  def initialize(value, connections=[])
    @value = value
    @connections = connections
  end

  def is_connected?(node)
    @connections.any? { |connection| connection[0] == node }
  end

  def <<(connection)
    @connections << connection
  end
end

class Graph
  # 1. @nodes is a collection of nodes that are interconnected

  attr_reader :nodes

  def initialize(matrix)
    @nodes = setup_graph(matrix)
  end

  def stops_between_nodes(node1, node2)
    return if @nodes.none? { |node| [node1, node2].include?(node) }
    least_number_of_stops(node1, node2)
  end

  private

  def least_number_of_stops(origin, destination, visited=[origin], stops=[])
    is_the_same_node = origin == destination
    destination_is_reachable = origin.is_connected?(destination)
    all_connections_have_been_visited = origin.connections.all? do |connection|
      visited.include?(connection[0])
    end
    return 0 if is_the_same_node
    if destination_is_reachable
      stops << visited.size
      return stops.min
    end
    return if all_connections_have_been_visited
    origin.connections.each do |connection|
      node = connection[0]
      unless visited.include?(node)
        visited_clone = visited.clone
        visited_clone << node
        least_number_of_stops(node, destination, visited_clone, stops)
      end
    end
    stops.min
  end

  def setup_graph(matrix)
    nodes = []
    matrix.size.times do |i|
      nodes << Node.new(i)
    end
    matrix.each_with_index do |row, row_idx|
      row.each_with_index do |dist, col_idx|
        unless nodes[row_idx].is_connected?(nodes[col_idx]) || dist.zero?
          nodes[row_idx] << [nodes[col_idx], dist]
        end
      end
    end
    nodes
  end
end

def weighted_graphs(matrix)
  # write your code here
  graph = Graph.new(matrix)
  stops = Array.new(matrix.size)
  stops.each_index do |idx|
    stops[idx] = graph.stops_between_nodes(graph.nodes[0], graph.nodes[idx])
  end
  stops
end

p weighted_graphs([[0, 0, 1, 3, 0, 0], [0, 0, 0, 5, 0, 0], [1, 0, 0, 2, 1, 4], [3, 5, 2, 0, 7, 0], [0, 0, 1, 7, 0, 2], [0, 0, 4, 0, 2, 0]])
# => [0, 2, 1, 1, 2, 2]
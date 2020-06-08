class Node
  attr_reader :neighbours, :value
  def initialize(value, neighbours={})
    @value = value
    @neighbours = neighbours
  end

  def add_to_neighbours(node, distance)
    neighbours[node] = distance
  end

  def is_connected_to?(node)
    return true if neighbours[node]
    false
  end

  def distance_to(node)
    return unless is_connected_to?(node)
    neighbours[node]
  end
end

class Graph
  def initialize(matrix)
    @nodes = build_nodes(matrix)
  end

  def [](idx)
    @nodes[idx]
  end

  def least_distance(origin, destination)
    distances = find_distances(origin, destination)
    distances.min
  end

  private

  def find_distances(origin, destination, total_distance=0, visited=[origin], distances=[])
    return [0] if origin == destination

    all_visited = visited.all? do |n|
      origin.is_connected_to?(n) && origin != n
    end

    return if all_visited

    origin.neighbours.each do |n, d|
      if n == destination
        distances << d + total_distance
      else
        unless visited.include?(n)
          visited_clone = visited.clone
          visited_clone << n

          find_distances(
            n,
            destination,
            total_distance + d,
            visited_clone,
            distances
          )
        end
      end
    end

    distances
  end

  def build_nodes(matrix)
    nodes = {}
    matrix.size.times do |i|
      node = Node.new(i)
      nodes[i] = node
    end
    matrix.each_with_index do |row, row_idx|
      row.each_with_index do |distance, col_idx|
        if row_idx != col_idx
          if distance != 0
            nodes[row_idx].add_to_neighbours(nodes[col_idx], distance)
          end
        end
      end
    end
    nodes
  end
end

def shortest_path_wg(matrix)
  graph = Graph.new(matrix)
  answer = [0]
  (1...matrix.size).each do |i|
    answer << graph.least_distance(graph[0], graph[i])
  end
  answer
end

# p shortest_path_wg([[0, 0, 1, 3, 0, 0], [0, 0, 0, 5, 0, 0], [1, 0, 0, 2, 1, 4], [3, 5, 2, 0, 7, 0], [0, 0, 1, 7, 0, 2], [0, 0, 4, 0, 2, 0]])
# => [0, 8, 1, 3, 2, 4]
p shortest_path_wg([[0, 3, 6, 0, 0, 9, 4], [3, 0, 4, 1, 0, 0, 0], [6, 4, 0, 3, 5, 4, 1], [0, 1, 3, 0, 2, 0, 0], [0, 0, 5, 2, 0, 3, 0], [9, 0, 4, 0, 3, 0, 3], [4, 0, 1, 0, 0, 3, 0]])
# => [0, 3, 5, 4, 6, 7, 4]

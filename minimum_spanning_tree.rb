def minimum_spanning_tree(matrix)
  nodes = [0]
  costs = []

  until nodes.size == matrix.size
    min_nodes = {}

    nodes.each do |node|
      min_cost = nil
      min_node = nil

      matrix[node].each_with_index do |c, d|
        next if nodes.include?(d)

        unless c.zero?
          if min_cost && c < min_cost
            min_node = d
            min_cost = c
          elsif !min_cost
            min_node = d
            min_cost = c
          end
        end
      end

      if min_node
        min_nodes[node] = { destination: min_node, cost: min_cost }
      end
    end

    min_node = nil
    min_cost = nil

    min_nodes.each do |k, v|
      if !min_node || v[:cost] < min_cost
        min_node = v[:destination]
        min_cost = v[:cost]
      end
    end

    costs << min_cost

    if !nodes.include?(min_node)
      nodes << min_node
    else
      break
    end
  end

  costs
end

# p minimum_spanning_tree(
#   [
#     [0, 4, 1, 4, 0, 0, 0, 0, 0, 0],
#     [4, 0, 5, 0, 9, 9, 0, 7, 0, 0],
#     [1, 5, 0, 3, 0, 0, 0, 9, 0, 0],
#     [4, 0, 3, 0, 0, 0, 0, 10, 0, 18],
#     [0, 9, 0, 0, 0, 2, 4, 0, 6, 0],
#     [0, 9, 0, 0, 2, 0, 2, 8, 0, 0],
#     [0, 0, 0, 0, 4, 2, 0, 9, 3, 9],
#     [0, 7, 9, 10, 0, 8, 9, 0, 0, 8],
#     [0, 0, 0, 0, 6, 0, 3, 0, 0, 9],
#     [0, 0, 0, 18, 0, 0, 9, 8, 9, 0]
#   ]
# )
# => [1, 3, 4, 7, 8, 2, 2, 3, 8]

# p minimum_spanning_tree(
#   [
#     [0, 0, 1, 3, 0, 0],
#     [0, 0, 0, 5, 0, 0],
#     [1, 0, 0, 2, 1, 4],
#     [3, 5, 2, 0, 7, 0],
#     [0, 0, 1, 7, 0, 2],
#     [0, 0, 4, 0, 2, 0]
#   ]
# )
# => [1, 1, 2, 2, 5]
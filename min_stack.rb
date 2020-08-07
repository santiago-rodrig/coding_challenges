class Node
  attr_accessor :value, :connection

  def initialize(value=nil, connection=nil)
    @value = value
    @connection = connection
  end
end

class MinStack
  def initialize
    @top = nil
    @mins = {}
  end

  def push(x)
    if @top
      node = Node.new(x)
      node.connection = @top
      @top = node

      if @mins.has_key?(x)
        @mins[x] += 1
      elsif x < self.get_min
        @mins[:smallest] = x
        @mins[x] = 1
        @mins[:sequence] << x
      end
    else
      @top = Node.new(x)
      @mins[:smallest] = x
      @mins[x] = 1
      @mins[:sequence] = [x]
    end
  end

  def pop
    output = @top.value
    @top = @top.connection

    if @mins.has_key?(output)
      @mins[output] -= 1

      if @mins[output].zero?
        @mins.delete(output)

        if output == self.get_min
          @mins[:sequence].pop
          @mins[:smallest] = @mins[:sequence].last
        end
      end
    end

    output
  end

  def top
    @top.value
  end

  def get_min
    @mins[:smallest]
  end
end
  
  # Your MinStack object will be instantiated and called as such:
  # obj = MinStack.new()
  # obj.push(x)
  # obj.pop()
  # param_3 = obj.top()
  # param_4 = obj.get_min()
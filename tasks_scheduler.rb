class Node
  attr_accessor :value, :connection

  def initialize(value=nil, connection=nil)
    @value = value
    @connection = connection

    self
  end

  def to_s
    @value.to_s
  end
end

class LinkedList
  def initialize(node=nil)
    @head = @tail = node

    self
  end
end

class MyQueue < LinkedList
  # we do care about the tail of the linked list when using queues

  def initialize(node=nil)
    super node
  end

  def <<(node)
    if @head
      @tail.connection = node
      @tail = node
    else
      @head = @tail = node
    end

    self
  end

  def pop
    if @head
      output = @head
      @head = @head.connection

      output
    else
      nil
    end
  end

  def empty?
    @head.nil?
  end

  def size
    node = @head
    counter = 0

    while node
      counter += 1
      node = node.connection
    end

    counter
  end

  def to_s
    str = []
    node = @head

    while node
      str << "(#{node})"
      node = node.connection
    end

    'Queue: ' + str.join('->')
  end
end

class MyStack < LinkedList
  # we do not care about the tail of the linked list when using stacks

  def initialize(node=nil)
    super node

    self
  end

  def <<(node)
    node.connection = @head
    @head = node

    self
  end

  def pop
    if @head
      output = @head
      @head = @head.connection

      output
    else
      nil
    end
  end

  def empty?
    @head.nil?
  end

  def size
    counter = 0
    node = @head

    while node
      counter += 1
      node = node.connection
    end

    counter
  end

  def to_s
    str = []
    node = @head

    while node
      str << "(#{node})"
      node = node.connection
    end

    'MyStack: ' + str.join('->')
  end
end

class Task < MyStack
  attr_reader :id

  include Comparable

  def initialize(id)
    @id = id
    @cooldown = 0
    super Node.new(id)

    self
  end

  def <<(node)
    node.value = @id
    super node

    self
  end

  def is_cooling?
    @cooldown.positive?
  end

  def reduce_cooldown
    @cooldown -= 1

    if @cooldown.negative?
      @cooldown = 0
    end

    true
  end

  def set_cooldown(duration)
    @cooldown = duration

    true
  end

  def <=>(task)
    self.size - task.size
  end
end

class TasksSchedule < MyStack
  def initialize(node=nil)
    super node
  end

  def <<(node)
    if is_greater_than_head?(node)
      node.connection = @head
      @head = node
    else
      current_node = @head

      while current_node
        if is_insertable?(node, current_node)
          node.connection = current_node.connection
          current_node.connection = node

          break
        end

        current_node = current_node.connection
      end
    end

    self
  end

  private

  def is_greater_than_head?(node)
    (@head && node.value > @head.value) || !@head
  end

  def is_insertable?(origin_node, target_node)
    greater_value = origin_node.value <= target_node.value
    smaller_value = target_node.connection && origin_node.value > target_node.connection.value
    connection_is_nil = target_node.connection.nil?
    greater_value && (smaller_value || connection_is_nil)
  end
end

class CoolingMyQueue < MyQueue
  def initialize(node=nil)
    super node
  end

  def reduce_cooldown
    task_node = @head

    while task_node
      task_node.value.reduce_cooldown
      task_node = task_node.connection
    end

    nil
  end

  def task_ready?
    if @head.value.is_cooling?
      false
    else
      self.pop
    end
  end
end

# @param {Character[]} tasks
# @param {Integer} n
# @return {Integer}
def least_interval(tasks, n)
  # tasks is an array of uppercase letters
  # n is the cooldown for a repeated task, it is an integer
  schedule = TasksSchedule.new
  tasks_mapping = {}

  tasks.each do |task_id|
    if tasks_mapping.has_key?(task_id)
      tasks_mapping[task_id].value << Node.new
    else
      tasks_mapping[task_id] = Node.new(Task.new(task_id))
    end
  end

  tasks_mapping.values.each { |task| schedule << task }
  cooling_queue = CoolingMyQueue.new
  cpu_time = 0

  perform_cooldown = -> do
    return if cooling_queue.empty?

    cooling_queue.reduce_cooldown
    cooled_task = cooling_queue.task_ready?

    if cooled_task
      schedule << cooled_task
    end
  end

  until schedule.empty? && cooling_queue.empty?
    task_node = schedule.pop

    unless task_node
      perform_cooldown.call
      cpu_time += 1

      next
    end

    task_node = Node.new(task_node.value)
    task_node.value.pop

    if task_node.value.empty?
      perform_cooldown.call
      cpu_time += 1

      next
    end

    task_node.value.set_cooldown(n)
    perform_cooldown.call
    cpu_time += 1
    cooling_queue << task_node
  end

  cpu_time
end

# puts least_interval(['A', 'A', 'A', 'B', 'B', 'B'], 2)
# => 8

# puts least_interval(['A', 'A', 'A', 'B', 'B', 'B'], 0)
# => 6

# puts least_interval(['A', 'A', 'A', 'A', 'A', 'A', 'B', 'C', 'D', 'E', 'F', 'G'], 2)
# => 16


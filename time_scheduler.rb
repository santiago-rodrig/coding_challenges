class TimePeriod
  include Comparable

  attr_reader :overlappings, :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
    @overlappings = []
  end

  def to_a
    (@start..@finish).to_a
  end

  def to_s
    "#{@start}-#{@finish}"
  end

  def overlaps
    @overlappings.size
  end

  def check_overlap_with(time_period)
    if time_period.start <= @finish && time_period.finish >= @start 
      @overlappings << time_period
    end
  end

  def delete_time_period(time_period)
    @overlappings.delete(time_period)
  end

  def clear_time_periods
    @overlappings.each { |e| e.delete_time_period(self) }
  end

  def <=>(time_period)
    return -1 if start < time_period.start

    return 1 if start > time_period.start

    0
  end
end

class Schedule
  def initialize(array)
    @events = prepared_events(array)
  end

  def optimized!
    @events = optimize(@events)

    self
  end

  def sort!
    @events.sort!

    self
  end

  def to_a
    @events.map { |e| [e.to_a[0], e.to_a.last] }
  end

  private

  def optimize(events)
    max_overlaps = events.map(&:overlaps).max

    if max_overlaps != 0
      overlapping_events = events.select do |e|
        e.overlaps == max_overlaps
      end

      overlapping_events.each do |e|
        e.clear_time_periods
      end

      return optimize(events - overlapping_events)
    end

    events
  end

  def prepare_overlappings(events)
    result = []
    event = nil

    events.size.times do |i|
      event = events[i]

      (events[0...i] + events[(i + 1)...events.size]).each do |e|
        event.check_overlap_with(e)
      end

      result << event
    end

    result
  end

  def prepared_events(array)
    events = []
    i = 0

    (array.size / 2).times do
      events.push(array[i, 2])
      i += 2
    end

    events.map! { |event| TimePeriod.new(*event) }
    events = prepare_overlappings(events)

    events
  end
end

def time_scheduler(array)
  Schedule.new(array).optimized!.sort!.to_a
end

# time_scheduler([4, 8, 1, 3, 7, 9, 5, 6])
# => [[1,3], [5,6], [7,9]]

p time_scheduler([3, 8, 1, 2, 3, 9, 1, 5, 4, 5, 8, 14])

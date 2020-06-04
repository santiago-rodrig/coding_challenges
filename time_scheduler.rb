# a time period is the span of time between two given hours
class TimePeriod
  # in order to sort a collection of time periods, include Comparable module
  include Comparable

  # getters for overlappings, start, and finish
  attr_reader :overlappings, :start, :finish

  def initialize(start, finish)
    # start: an integer representing the beginning of the time period
    # finish: ... the end ...
    @start = start
    @finish = finish
    # overlappings is going to hold the set of time periods that overlap
    # with this time period
    @overlappings = []
  end

  # turn a time period into an array for the final result
  def to_a
    (@start..@finish).to_a
  end

  # for debugging, define a time period string representation
  def to_s
    "#{@start}-#{@finish}"
  end

  # fetch the count of overlappings for this time period
  def overlaps
    @overlappings.size
  end

  # check if this time period overlaps with the given time period
  def check_overlap_with(time_period)
    if time_period.start <= @finish && time_period.finish >= @start
      @overlappings << time_period
    end
  end

  # delete a time period from the overlappings collection
  def delete_time_period(time_period)
    @overlappings.delete(time_period)
  end

  # delete this time period from each overlapping time period
  def clear_time_periods
    @overlappings.each { |e| e.delete_time_period(self) }
  end

  # used by sort, defined by Comparable
  def <=>(time_period)
    return -1 if start < time_period.start

    return 1 if start > time_period.start

    0
  end
end

# Representation of a collection of time periods
class Schedule
  def initialize(array)
    @events = prepared_events(array)
  end

  # optimize the collection of events (time periods) by giving the maximum
  # number of events that can be attended
  def optimized!
    @events = optimize(@events)

    self
  end

  # sorts the collection of events
  def sort!
    @events.sort!

    self
  end

  # turn into an array for the final result
  def to_a
    @events.map { |e| [e.to_a[0], e.to_a.last] }
  end

  private

  # optimize the collection of events
  def optimize(events)
    # get the event with most overlappings
    max_overlaps = events.map(&:overlaps).max

    # if there is such an event
    if max_overlaps != 0
      # get the collecton of events that overlap with this event
      overlapping_events = events.select do |e|
        e.overlaps == max_overlaps
      end

      # delete each overlapping event from the events they overlap with
      overlapping_events.each do |e|
        e.clear_time_periods
      end

      # call optimize with the events that don't overlap with the one that
      # has the most number of overlappings
      return optimize(events - overlapping_events)
    end

    # return events if there are no overlappings
    events
  end

  # prepare each time period to parse the number of overlappings with the
  # rest of time periods in the collection
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

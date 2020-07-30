# challenge: https://leetcode.com/problems/insert-interval/

# @param {Integer[][]} intervals
# @param {Integer[]} new_interval
# @return {Integer[][]}
def insert(intervals, new_interval)
  it_overlaps = -> (interval1, interval2) do
    condition1 = (interval1[0] >= interval2[0]) && (interval1[0] <= interval2[1])
    condition2 = (interval1[1] >= interval2[0]) && (interval1[1] <= interval2[1])
    condition3 = (interval1[0] >= interval2[0]) && (interval1[1] <= interval2[1])
    condition4 = (interval1[0] <= interval2[0]) && (interval1[1] >= interval2[1])
    result = nil
    case
    when condition4
      result = 4
    when condition3
      result = 3
    when condition2
      result = 2
    when condition1
      result = 1
    end
    result
  end
  merge_intervals = -> (interval1, interval2, condition) do
    # condition 1: the left boundary of the first is between the second
    # condition 2: the right boundary of the first is between the second
    # condition 3: the first is contained in the second
    merging = [nil, nil]
    case condition
    when 1
      merging[0] = interval2[0]
      merging[1] = interval1[1]
    when 2
      merging[0] = interval1[0]
      merging[1] = interval2[1]
    when 3
      merging[0] = interval2[0]
      merging[1] = interval2[1]
    when 4
      merging[0] = interval1[0]
      merging[1] = interval1[1]
    end
    merging
  end
  first_overlap_condition = nil
  first_overlap = nil
  intervals.each_with_index do |interval, i|
    first_overlap_condition = it_overlaps.call(new_interval, interval)
    if first_overlap_condition
      first_overlap = i
      break
    end
  end
  if first_overlap
    # there is an overlapping
    last_overlap = intervals.size - 1
    ((first_overlap + 1)...intervals.size).each do |i|
      interval = intervals[i]
      condition = it_overlaps.call(new_interval, interval)
      unless condition
        last_overlap = i - 1
        break
      end
    end
    merging = merge_intervals.call(new_interval, intervals[first_overlap], first_overlap_condition)
    last_overlap_condition = it_overlaps.call(merging, intervals[last_overlap])
    merging = merge_intervals.call(merging, intervals[last_overlap], last_overlap_condition)
    intervals[first_overlap..last_overlap] = [merging]
  else
    # there are no overlappings
    if intervals.empty?
      intervals.push(new_interval)
    else
      case
      when new_interval[0] < intervals.first[0]
        intervals.unshift(new_interval)
      when new_interval[0] > intervals.last[1]
        intervals.push(new_interval)
      else
        right_boundary = intervals.find_index { |interval| interval[0] > new_interval[1] }
        intervals.insert(right_boundary, new_interval)
      end
    end
  end
  intervals
end

# insert([[1,3],[6,9]], [2,5])
# insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4, 8])
# insert([], [5, 7])
insert([[3,5],[12,15]],[6,6])

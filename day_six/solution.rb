#!/usr/bin/ruby

sample_lines = File.read("SAMPLE.txt").split("\n")
lines = File.read("INPUT.txt").split("\n")

## PART ONE ##
def margin_of_error(lines)
  time_record_map = parse_time_records(lines)

  answer = 1
  time_record_map.each do |time, record_distance|
    answer *= calculate_ways_to_win(time, record_distance)
  end
  puts answer
end

## PART TWO ##
def margin_of_error_two(lines)
  time, record = join_time_records(lines)
  answer = calculate_ways_to_win(time, record)
  puts answer
end

## HELPER METHODS ##
def parse_time_records(lines)
  time_record_map = {}
  lines[0].split(" ").each_with_index do |time, index|
    if index == 0
      next
    end
    time_record_map[time.to_i] = lines[1].split(" ")[index].to_i
  end
  time_record_map
end

def join_time_records(lines)
  time = lines[0].split(":")[1].split(" ").join("")
  record = lines[1].split(":")[1].split(" ").join("")
  [time.to_i, record.to_i]
end

def calculate_ways_to_win(race_time, record_distance)
  midpoint = (race_time + 1) / 2 # round up
  start_winning_speed = 0

  for speed in 1..race_time/2
    distance_traveled = speed * (race_time - speed)
    if distance_traveled > record_distance
      start_winning_speed = speed
      break
    end
  end
  ways_to_win = (midpoint - start_winning_speed) * 2
  ways_to_win += 1 if race_time % 2 == 0
  # puts ways_to_win
  ways_to_win
end

# margin_of_error(lines)
margin_of_error_two(lines)
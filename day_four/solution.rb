#!/usr/bin/ruby

sample_lines = File.read("SAMPLE.txt").split("\n")
lines = File.read("INPUT.txt").split("\n")

## PART ONE ##
def points_won(lines)
  points = 0
  lines.each do |line|
    winning_numbers = line.split("|")[0].split(":")[1].split(" ")
    player_numbers = line.split("|")[1].split(" ")
    count_of_winning_numbers = 0
    player_numbers.each do |number|
      if winning_numbers.include?(number)
        count_of_winning_numbers += 1
      end
    end
    points += 2 ** (count_of_winning_numbers-1) if count_of_winning_numbers > 0
  end
  puts points
end

# points_won(sample_lines)
# points_won(lines)

## PART TWO ##
def total_card_count(lines)
  card_count = {}
  last_card_number = lines.length
  (1..last_card_number).each do |card_number|
    card_count[card_number] = 1
  end

  lines.each do |line|
    card_number = line.split(" ")[1].split(":")[0].to_i
    winning_numbers = line.split("|")[0].split(":")[1].split(" ")
    player_numbers = line.split("|")[1].split(" ")
    count_of_winning_numbers = 0
    player_numbers.each do |number|
      count_of_winning_numbers += 1 if winning_numbers.include?(number)
    end

    (card_number+1..card_number+count_of_winning_numbers).each do |card_number_copies|
      break if card_number_copies > last_card_number
      card_count[card_number_copies] += card_count[card_number]
    end
  end
  puts card_count.values.sum
end

total_card_count(sample_lines)
total_card_count(lines)

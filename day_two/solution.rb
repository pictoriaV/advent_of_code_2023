#!/usr/bin/ruby

sample_games = File.read("SAMPLE.txt").split("\n")
games = File.read("INPUT.txt").split("\n")

RED = 12
GREEN = 13
BLUE = 14

## PART ONE ##
def possible_games(sample_games)
  total = 0
  sample_games.each do |row|
    game_number = row.split(":")[0].split(" ")[1].to_i
    game = row.split(":")[1]
    pulls = game.split(";")
    min_cubes_per_game = max_color_per_game(pulls)

    # Solution for Part 1
    is_possible = min_cubes_per_game[:red] <= RED && min_cubes_per_game[:green] <= GREEN && min_cubes_per_game[:blue] <= BLUE

    total += game_number.to_i if is_possible
    puts "Game #{game_number} is possible: #{is_possible}"
  end
  puts total
end

## PART TWO ##
def fewest_number_cubes_per_game(sample_games)
  total = 0
  sample_games.each do |row|
    game = row.split(":")[1]
    pulls = game.split(";")
    min_cubes_per_game = max_color_per_game(pulls)

    # Solution for Part 2
    total += power_of_cubes(min_cubes_per_game[:red], min_cubes_per_game[:green], min_cubes_per_game[:blue])
  end
  puts total
end

## HELPER METHODS ##
def max_color_per_game(pulls)
  max_color_per_game = {"red": 0, "blue": 0, "green": 0}
  pulls.each do |pull|
    pull.split(", ").each do |number_color|
      number = number_color.split(" ")[0]
      color = number_color.split(" ")[1]

      max_color_per_game[color.to_sym] = number.to_i if number.to_i > max_color_per_game[color.to_sym]
    end
  end
  return max_color_per_game
end

def power_of_cubes(red, green, blue)
  red * green * blue
end

## EXECUTION ##
# possible_games(sample_games)
fewest_number_cubes_per_game(games)
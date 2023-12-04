#!/usr/bin/ruby

sample_lines = File.read("SAMPLE.txt").split("\n")
lines = File.read("INPUT.txt").split("\n")

def part_one(lines)
  sum = 0
  lines.each_with_index do |line, line_index|
    skip_indices = []
    line.split("").each_with_index do |char, char_index|
      if char.match?(/\d/) && !skip_indices.include?(char_index) &&  has_adjacent_symbol(lines, line_index, line, char_index)
          # get all digits to the left and right of char
          left_digits = get_left_digits(line, char_index)
          right_digits, skip_right_indices = get_right_digits_with_skips(line, char_index)
          actual_digit = left_digits + char + right_digits

          skip_indices += skip_right_indices
          sum += actual_digit.to_i
      end
    end
  end
  puts sum
end

def part_two(lines)
  sum = 0
  lines.each_with_index do |line, line_index|
    line.split("").each_with_index do |char, char_index|
      if char.match?(/\*/)
        sum += multiply_adjacent_numbers(lines, line_index, line, char_index)
      end
    end
  end
  puts sum
end

def get_actual_digits(line, char_index)
  left_digits = get_left_digits(line, char_index)
  right_digits = get_right_digits(line, char_index)
  (left_digits + line[char_index] + right_digits)
end

def get_left_digits(line, char_index)
  left_digits = ""
  index = char_index - 1
  while index >= 0
    if line[index].match?(/\d/)
      left_digits += line[index]
    else
      break
    end
    index -= 1
  end
  left_digits.reverse
end

def get_right_digits_with_skips(line, char_index)
  right_digits = ""
  skip_indicies = []
  index = char_index + 1
  while index < line.length
    if line[index].match?(/\d/)
      right_digits += line[index]
      skip_indicies << index
    else
      break
    end
    index += 1
  end
  return right_digits, skip_indicies

end

def get_right_digits(line, char_index)
  right_digits = ""
  index = char_index + 1
  while index < line.length
    if line[index].match?(/\d/)
      right_digits += line[index]
    else
      break
    end
    index += 1
  end
  return right_digits

end

def has_adjacent_symbol(lines, line_index, line, char_index)
  return true if index_in_bounds?(char_index - 1, line.length) && check_for_symbol(line[char_index - 1])# check left
  return true if index_in_bounds?(char_index + 1, line.length) && check_for_symbol(line[char_index + 1])# check right
  return true if index_in_bounds?(line_index - 1, lines.length) && check_for_symbol(lines[line_index - 1][char_index])# check above
  return true if index_in_bounds?(line_index + 1, lines.length) && check_for_symbol(lines[line_index + 1][char_index])# check below
  return true if index_in_bounds?(line_index - 1, lines.length) && index_in_bounds?(char_index - 1, line.length) && check_for_symbol(lines[line_index - 1][char_index - 1])# check top left
  return true if index_in_bounds?(line_index - 1, lines.length) && index_in_bounds?(char_index + 1, line.length) && check_for_symbol(lines[line_index - 1][char_index + 1])# check top right
  return true if index_in_bounds?(line_index + 1, lines.length) && index_in_bounds?(char_index - 1, line.length) && check_for_symbol(lines[line_index + 1][char_index - 1])# check bottom left
  return true if index_in_bounds?(line_index + 1, lines.length) && index_in_bounds?(char_index + 1, line.length) && check_for_symbol(lines[line_index + 1][char_index + 1])# check bottom right
  return false
end

def multiply_adjacent_numbers(lines, line_index, line, char_index)
  digits_adjacent_to_gear = []
  current_char = line[char_index]
  if index_in_bounds?(char_index - 1, line.length) && check_for_number(line[char_index - 1])# check left
    digits_adjacent_to_gear << (get_left_digits(line, char_index)).to_i
  end
  if index_in_bounds?(char_index + 1, line.length) && check_for_number(line[char_index + 1])# check right
    digits_adjacent_to_gear << (get_right_digits(line, char_index)).to_i
  end

  # get actual number else check top left and top right
  if index_in_bounds?(line_index - 1, lines.length) && check_for_number(lines[line_index - 1][char_index])# check above
    digits_adjacent_to_gear << (get_actual_digits(lines[line_index - 1], char_index)).to_i
  else
    if index_in_bounds?(line_index - 1, lines.length) && index_in_bounds?(char_index - 1, line.length) && check_for_number(lines[line_index - 1][char_index - 1])# check top left
      digits_adjacent_to_gear << (get_left_digits(lines[line_index - 1], char_index )).to_i
    end
    if index_in_bounds?(line_index - 1, lines.length) && index_in_bounds?(char_index + 1, line.length) && check_for_number(lines[line_index - 1][char_index + 1])# check top right
      digits_adjacent_to_gear << (get_right_digits(lines[line_index - 1], char_index)).to_i
    end
  end
  # same for check bottom
  if index_in_bounds?(line_index + 1, lines.length) && check_for_number(lines[line_index + 1][char_index])# check below
    digits_adjacent_to_gear << (get_actual_digits(lines[line_index + 1], char_index)).to_i
  else
    if index_in_bounds?(line_index + 1, lines.length) && index_in_bounds?(char_index - 1, line.length) && check_for_number(lines[line_index + 1][char_index - 1])# check bottom left
      digits_adjacent_to_gear << (get_left_digits(lines[line_index + 1], char_index)).to_i
    end
    if index_in_bounds?(line_index + 1, lines.length) && index_in_bounds?(char_index + 1, line.length) && check_for_number(lines[line_index + 1][char_index + 1])# check bottom right
      digits_adjacent_to_gear << (get_right_digits(lines[line_index + 1], char_index)).to_i
    end
  end
  # multiply all digits in digits_adjacent_to_gear
  digits_adjacent_to_gear.length > 1 ? digits_adjacent_to_gear.inject(:*) : 0
end

def index_in_bounds?(index, length)
  index >= 0 && index < length
end

def check_for_symbol(char)
  char.match?(/\W/) && char != "."
end

def check_for_number(char)
  char.match?(/\d/)
end

# part_one(lines)
part_two(lines)
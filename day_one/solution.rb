#!/usr/bin/ruby

sample_lines = File.read("SAMPLE.txt").split("\n")
lines = File.read("INPUT.txt").split("\n")

ENGLISH_TO_NUMBERS = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}
REVERSED_ENGLISH_TO_NUMBERS = {
  "eno" => 1,
  "owt" => 2,
  "eerht" => 3,
  "ruof" => 4,
  "evif" => 5,
  "xis" => 6,
  "neves" => 7,
  "thgie" => 8,
  "enin" => 9
}

def add_first_and_last_digits(lines)
  tens_place = 0
  ones_place = 0
  lines.each do |line|
    first_digit = line.scan(/\d/).first.to_i
    last_digit = line.scan(/\d/).last.to_i

    tens_place += first_digit
    ones_place += last_digit
  end

  total = tens_place * 10 + ones_place
  puts total
end

def decode_and_add_first_and_last_digits(lines)
  tens_place = 0
  ones_place = 0
  lines.each do |line|
    first_match = line.match(/one|two|three|four|five|six|seven|eight|nine|\d/)[0]
    last_match = line.reverse.match(/eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|\d/)[0]
    first_digit = replace_with_digit(first_match)
    last_digit = replace_with_digit(last_match, reverse=true)
    tens_place += first_digit
    ones_place += last_digit
  end
  total = tens_place * 10 + ones_place
  puts total
end

private

def replace_with_digit(word_or_digit, reverse=false)
  if word_or_digit.to_i > 0
    return word_or_digit.to_i
  else
    return reverse ? REVERSED_ENGLISH_TO_NUMBERS[word_or_digit] : ENGLISH_TO_NUMBERS[word_or_digit]
  end
end

decode_and_add_first_and_last_digits(lines)


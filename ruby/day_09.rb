# frozen_string_literal: true

def play(num_players, num_marbles)
  marbles = [0]
  scores = Hash.new(0)
  current_marble_idx = 0
  current_player = 0

  (1...num_marbles).each do |marble_number|
    puts 100 * marble_number / num_marbles.to_f if (marble_number % 10000).zero?

    if (marble_number % 23).zero?
      current_marble_idx = (current_marble_idx - 7) % marbles.length
      scores[current_player] += marble_number + marbles.delete_at(current_marble_idx)
    else
      current_marble_idx = (current_marble_idx + 2) % marbles.length
      marbles.insert(current_marble_idx, marble_number)
    end

    current_player = (current_player + 1) % num_players
  end

  scores.values.max
end

def part_one
  play(411, 71_170)
end

def part_two
  play(411, 71_170 * 100)
end

if $PROGRAM_NAME == __FILE__
  puts 'https://adventofcode.com/2018/day/9'

  puts "Part One: #{part_one}"
  puts "Part Two: #{part_two}"
end

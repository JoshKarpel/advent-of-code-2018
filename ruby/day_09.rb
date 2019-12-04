# frozen_string_literal: true

class Marble
  attr_reader :score
  attr_accessor :ccw, :cw

  def initialize(score, ccw, cw)
    @score = score
    @ccw = ccw || self
    @cw = cw || self
  end

  def move_ccw(n)
    marble = self
    n.times do
      marble = marble.ccw
    end
    marble
  end

  def move_cw(n)
    marble = self
    n.times do
      marble = marble.cw
    end
    marble
  end
end

def play(num_players, num_marbles)
  current_marble = Marble.new(0, nil, nil)
  scores = Hash.new(0)
  current_player = 0

  (1...num_marbles).each do |marble_number|
    if (marble_number % 23).zero?
      remove = current_marble.move_ccw 7
      before = remove.move_ccw 1
      after = remove.move_cw 1
      before.cw = after
      after.ccw = before
      current_marble = after

      scores[current_player] += marble_number + remove.score
    else
      before = current_marble.move_cw 1
      after = before.move_cw 1

      current_marble = Marble.new(marble_number, before, after)
      before.cw = current_marble
      after.ccw = current_marble
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

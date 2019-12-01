# frozen_string_literal: true

require 'pathname'
require 'set'

def read_frequencies
  (Pathname(__dir__).parent / 'data' / 'day_01.txt').readlines.map(&:to_i)
end

def part_one(frequencies)
  frequencies.sum
end


def part_two(frequencies)
  seen = Set.new
  curr = 0
  frequencies.cycle do |f|
    curr += f
    return curr if seen.add?(curr).nil?
  end
end

if $PROGRAM_NAME == __FILE__
  data = read_frequencies
  puts "Part One: #{part_one(data)}"
  puts "Part Two: #{part_two(data)}"
end

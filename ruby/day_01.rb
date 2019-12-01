# frozen_string_literal: true

require 'pathname'
require 'set'

def read_data
  (Pathname(__dir__).parent / 'data' / 'day_01.txt').readlines.map(&:to_i)
end

def part_one(data)
  data.sum
end


def part_two(data)
  seen = Set.new
  curr = 0
  data.cycle do |f|
    curr += f
    return curr if seen.add?(curr).nil?
  end
end

if $PROGRAM_NAME == __FILE__
  data = read_data
  puts "Part One: #{part_one(data)}"
  puts "Part Two: #{part_two(data)}"
end

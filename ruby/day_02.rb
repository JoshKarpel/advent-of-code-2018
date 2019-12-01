# frozen_string_literal: true

require 'pathname'

def read_data
  (Pathname(__dir__).parent / 'data' / 'day_02.txt').readlines.map(&:chomp)
end

module Enumerable
  def tally
    tally = Hash.new(0)
    each { |element| tally[element] += 1 }
    tally
  end
end

def part_one(data)
  counts = Hash.new(0)
  data.each do |id|
    id.each_char.tally.invert.each do |count, _|
      counts[count] += 1
    end
  end
  counts[2] * counts[3]
end

def part_two(data)
end

if $PROGRAM_NAME == __FILE__
  data = read_data
  puts "Part One: #{part_one(data)}"
  puts "Part Two: #{part_two(data)}"
end

# frozen_string_literal: true

require 'pathname'

def read_ids
  (Pathname(__dir__).parent / 'data' / 'day_02.txt').readlines.map(&:chomp)
end

module Enumerable
  def tally
    tally = Hash.new(0)
    each { |element| tally[element] += 1 }
    tally
  end
end

def part_one(ids)
  counts = Hash.new(0)
  ids.each do |id|
    id.each_char.tally.invert.each do |count, _|
      counts[count] += 1
    end
  end
  counts[2] * counts[3]
end

def part_two(ids)
  ids[0].size.times do |position|
    sliced_ids = ids.map { |s| s[0..position - 1] + s[position + 1..-1] }
    maybe_exactly_two = sliced_ids.tally.invert[2]
    return maybe_exactly_two unless maybe_exactly_two.nil?
  end
end

if $PROGRAM_NAME == __FILE__
  ids = read_ids
  puts "Part One: #{part_one(ids)}"
  puts "Part Two: #{part_two(ids)}"
end

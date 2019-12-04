# frozen_string_literal: true

require 'pathname'

INSTRUCTION_REGEX = /^Step (.) must be finished before step (.) can begin\.$/

def read_instructions
  (Pathname(__dir__).parent / 'data' / 'day_07.txt').readlines.map do |line|
    INSTRUCTION_REGEX.match(line)[1..2]
  end
end

def dependencies(instructions)
  deps = {}

  instructions.each do |parent, child|
    # ensure both parent and child are in the dependency graph
    deps[parent] ||= []
    deps[child] ||= []

    deps[child] << parent
  end

  deps
end

def part_one(instructions)
  deps = dependencies instructions
  puts deps.to_s

  order = []
  while deps.length.positive? do
    puts
    ready = (deps.map { |child, parents| child if parents.length.zero? }).compact.sort!.first
    puts ready.to_s

    order << ready
    puts order.to_s

    deps.delete(ready)
    deps.each_value { |parents| parents.delete(ready) }
  end

  order.join
end

def part_two(instructions)
end

if $PROGRAM_NAME == __FILE__
  puts 'https://adventofcode.com/2018/day/7'

  instructions = read_instructions
  puts instructions.to_s

  puts "Part One: #{part_one(instructions)}"
  puts "Part Two: #{part_two(instructions)}"
end

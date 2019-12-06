# frozen_string_literal: true

require 'pathname'

INSTRUCTION_REGEX = /^Step (.) must be finished before step (.) can begin\.$/.freeze

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

  order = []
  while deps.length.positive?
    ready = (deps.map { |child, parents| child if parents.length.zero? }).compact.sort!.first

    order << ready

    deps.delete(ready)
    deps.each_value { |parents| parents.delete(ready) }
  end

  order.join
end

def part_two(instructions, num_workers)
  deps = dependencies instructions

  time = 0
  in_progress = {}
  while deps.length.positive? || in_progress.length.positive?
    ready = (deps.map { |child, parents| child if parents.length.zero? }).compact.sort!
    while in_progress.length < num_workers && ready.length.positive?
      r = ready.shift
      deps.delete r
      in_progress[r] = r.ord - 'A'.ord + 1 + 60
    end

    in_progress.each do |k, v|
      next unless (in_progress[k] = v - 1).zero?

      in_progress.delete k
      deps.each_value { |parents| parents.delete(k) }
    end

    time += 1
  end

  time
end

if $PROGRAM_NAME == __FILE__
  puts 'https://adventofcode.com/2018/day/7'

  instructions = read_instructions

  puts "Part One: #{part_one(instructions)}"
  puts "Part Two: #{part_two(instructions, 5)}"
end

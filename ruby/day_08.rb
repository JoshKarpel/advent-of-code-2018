# frozen_string_literal: true

require 'pathname'

def read_numbers
  (Pathname(__dir__).parent / 'data' / 'day_08.txt').read.split(' ').map(&:to_i)
end

class Node
  attr_accessor :children, :metadata

  def initialize
    @children = []
    @metadata = []
  end

  def walk(&block)
    @children.each do |child|
      child.walk(&block)
    end
    yield self
  end

  def reduce(initial = 0, &block)
    acc = initial
    @children.each do |child|
      acc = child.reduce(acc, &block)
    end
    yield acc, self
  end

  def value
    return @metadata.sum if @children.length.zero?

    indices = ((@metadata.select { |m| m.between?(1, @children.length) }).map { |m| m - 1 })
    indices.reduce(0) do |acc, m|
      acc + @children[m].value
    end
  end
end

def parse(numbers, parent = nil)
  return if numbers.length.zero?

  node = Node.new
  parent.children << node unless parent.nil?

  num_children, num_metadata = numbers.shift(2)
  num_children.times do
    parse(numbers, node)
  end

  node.metadata += numbers.shift(num_metadata)
  node
end

def part_one(root)
  root.reduce do |acc, node|
    acc + node.metadata.sum
  end
end

def part_two(root)
  root.value
end

if $PROGRAM_NAME == __FILE__
  puts 'https://adventofcode.com/2018/day/8'

  numbers = read_numbers

  root = parse(numbers)

  puts "Part One: #{part_one(root)}"
  puts "Part Two: #{part_two(root)}"
end

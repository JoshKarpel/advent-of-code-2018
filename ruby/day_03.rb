# frozen_string_literal: true

require 'pathname'

def read_claims
  (Pathname(__dir__).parent / 'data' / 'day_03.txt').readlines.map do |line|
    Claim.extract(line)
  end
end

class Claim
  def initialize(id, x, y, w, h)
    @id = id
    @x = x
    @y = y
    @w = w
    @h = h
  end

  def to_s
    "Claim(#{@id}, x = #{@x}, y = #{@y}, w = #{@w}, h = #{@h})"
  end

  REGEX = /^#(\d+)\s@\s(\d+),(\d+):\s(\d+)x(\d+)$/.freeze

  def self.extract(claim)
    if (matches = REGEX.match(claim))
      Claim.new(*matches[1..-1].map(&:to_i))
    end
  end

  def squares
    (@x...(@x + @w)).each do |x|
      (@y...(@y + @h)).each do |y|
        yield x, y
      end
    end
  end
end

def part_one(claims)
  squares = Hash.new(0)
  claims.each do |claim|
    claim.squares do |x, y|
      squares[[x, y]] += 1
    end
  end
  squares.count { |_, v| v >= 2 }
end

def part_two(claims)
  ;
end

if $PROGRAM_NAME == __FILE__
  claims = read_claims
  puts "Part One: #{part_one(claims)}"
  puts "Part Two: #{part_two(claims)}"
end

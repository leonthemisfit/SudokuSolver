#!/usr/bin/ruby

# frozen_string_literal: true

require_relative 'parser'
require_relative 'checks'

include Sudoku

board = Parser.parse_file(ARGV[0])

unless board.valid?
  puts 'Invalid Board!'
  exit(1)
end

until board.won? do
  changed = false

  changed = true if Checks.pencil(board)
  changed = true if Checks.group(board, :rows)
  changed = true if Checks.group(board, :columns)
  changed = true if Checks.group(board, :boxes)

  break unless changed
end

puts "WON: #{board.won?}"
puts "VALID: #{board.valid?}"
puts ""

(0..8).each do |y|
  (0..8).each do |x|
    print (board[x, y].value || '*')
    print ' '
  end
  print "\n"
end


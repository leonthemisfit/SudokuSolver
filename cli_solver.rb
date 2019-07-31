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

until board.won?
  break unless Checks.pencil(board) ||
               Checks.group(board, :rows) ||
               Checks.group(board, :columns) ||
               Checks.group(board, :boxes)
end

puts "WON: #{board.won?}"
puts "VALID: #{board.valid?}"
puts ''

(0..8).each do |y|
  (0..8).each do |x|
    print (board[x, y].value || '*')
    print ' '
  end
  print "\n"
end


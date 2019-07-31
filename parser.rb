# frozen_string_literal: true

require_relative 'board'
require_relative 'square'

module Sudoku
  module Parser
    GRID_COORD = {
      [0, 0] => 0,
      [0, 1] => 1,
      [0, 2] => 2,
      [1, 0] => 3,
      [1, 1] => 4,
      [1, 2] => 5,
      [2, 0] => 6,
      [2, 1] => 7,
      [2, 2] => 8
    }.freeze

    def self.grid(ind)
      case ind
      when 0..2
        0
      when 3..5
        1
      when 6..8
        2
      end
    end

    def self.parse_row(str, row, delim = ' ', blank = '*')
      str.split(delim).each_with_index.map do |item, ind|
        grid_x = grid(ind)
        grid_y = grid(row)
        box = GRID_COORD[[grid_x, grid_y]]

        value = nil
        const = false

        unless item == blank
          value = item.to_i
          const = true
        end

        square = Square.new(value, const)
        square.row = row
        square.column = ind
        square.box = box

        square
      end
    end

    def self.parse_rows(rows, delim = ' ', blank = '*')
      rows.each_with_index.map do |row, ind|
        parse_row(row, ind, delim, blank)
      end
    end

    def self.parse_board(rows, delim = ' ', blank = '*')
      cells = parse_rows(rows, delim, blank).flatten
      board = Board.new
      cells.each { |cell| board << cell }
      board
    end

    def self.parse_file(path, delim = ' ', blank = '*')
      lines = File.readlines(path).map(&:chomp)
      parse_board(lines, delim, blank)
    end
  end
end


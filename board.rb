# frozen_string_literal: true

require_relative 'group'

module Sudoku
  class Board
    attr_reader :rows, :columns, :boxes

    def initialize
      @rows = (1..9).map { Group.new }
      @columns = (1..9).map { Group.new }
      @boxes = (1..9).map { Group.new }
    end

    def add_square(square)
      @rows[square.row] << square
      @columns[square.column] << square
      @boxes[square.box] << square
    end

    def <<(square)
      add_square(square)
    end

    def pencil_square(square)
      return false if square.constant? || square.complete?

      pencil = (1..9).to_a
      pencil -= @rows[square.row].values
      pencil -= @columns[square.column].values
      pencil -= @boxes[square.box].values

      unless square.pencil == pencil
        square.pencil = pencil
        return true
      end

      false
    end

    def set_value(square, val)
      square.value = val

      @rows[square.row].each do |sq|
        pencil_square(sq)
      end

      @columns[square.column].each do |sq|
        pencil_square(sq)
      end

      @boxes[square.box].each do |sq|
        pencil_square(sq)
      end
    end

    def [](x, y)
      @rows[y].squares[x]
    end

    def each(&block)
      (0..8).each do |y|
        (0..8).each do |x|
          block.call(self[x, y])
        end
      end
    end

    def valid?
      @rows.each do |group|
        return false unless group.valid?
      end

      @columns.each do |group|
        return false unless group.valid?
      end

      @boxes.each do |group|
        return false unless group.valid?
      end

      true
    end

    def complete?
      @boxes.each do |group|
        return false unless group.complete?
      end

      true
    end

    def won?
      valid? && complete?
    end
  end
end


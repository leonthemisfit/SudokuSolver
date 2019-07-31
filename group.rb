# frozen_string_literal: true

module Sudoku
  class Group
    attr_reader :squares

    def initialize
      @squares = []
    end

    def add_square(square)
      @squares << square
    end

    def <<(square)
      add_square(square)
    end

    def each(&block)
      @squares.each { |sq| block.call(sq) }
    end

    def values
      vals = @squares.map(&:value)
      vals.reject { |val| val.nil? || val.zero? }
    end

    def needed
      (1..9).to_a - values
    end

    def valid?
      values.length == values.uniq.length
    end

    def complete?
      needed.length.zero?
    end
  end
end


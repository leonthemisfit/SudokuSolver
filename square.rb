# frozen_string_literal: true

module Sudoku
  class Square
    attr_reader :value
    attr_accessor :pencil, :row, :column, :box

    def initialize(value, constant = false)
      @value = value
      @constant = constant
      @complete = constant

      @pencil = []
    end

    def check
      return false if @constant || @complete
      return false unless @pencil.length == 1

      @value = @pencil[0]
      @complete = true

      true
    end

    def set_value(val)
      @pencil = [val]
      check
    end

    def value=(val)
      set_value(val)
    end

    def constant?
      @constant
    end

    def complete?
      @complete
    end
  end
end


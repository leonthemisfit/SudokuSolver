# frozen_string_literal: true

module Sudoku
  module Checks
    def self.pencil(board)
      changed = false

      board.each do |square|
        next if square.constant? || square.complete?

        changed = changed ||
                  board.pencil_square(square) ||
                  square.check
      end

      changed
    end

    def self.group(board, group_name)
      changed = false

      groups = board.public_send(group_name)

      groups.each do |grp|
        changed = true if handle_group(grp)
      end

      changed
    end

    def self.handle_group(grp)
      changed = false

      grp.each do |square|
        next if square.constant? || square.complete?

        changed = true if handle_square(square, grp)
      end

      changed
    end

    def self.handle_square(square, grp)
      changed = false

      pencils = (grp.squares - [square]).map(&:pencil).flatten.uniq
      rem = square.pencil - pencils

      if rem.length == 1
        square.value = rem[0]
        changed = true
      end

      changed
    end
  end
end


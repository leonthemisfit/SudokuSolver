# frozen_string_literal: true

module Sudoku
  module Checks
    def self.pencil(board)
      changed = false

      board.each do |square|
        next if square.constant? || square.complete?

        if board.pencil_square(square)
          changed = true
        end

        if square.check
          changed = true
        end
      end

      changed
    end

    def self.group(board, group_name)
      changed = false

      groups = board.public_send(group_name)

      groups.each do |grp|
        grp.squares.each do |square|
          next if square.constant? || square.complete?

          pencils = (grp.squares - [square]).map { |sq| sq.pencil }.flatten.uniq
          rem = square.pencil - pencils

          if rem.length == 1
            board.set_value(square, rem[0])
            changed = true
          end
        end
      end

      changed
    end
  end
end


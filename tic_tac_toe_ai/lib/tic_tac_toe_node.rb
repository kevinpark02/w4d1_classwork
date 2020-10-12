require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    output = []
    @board.rows.each_with_index do |row, x|
      row.each_with_index do |pos, y|
        if pos.nil?
          duped_board = @board.dup
          duped_board[[x, y]] = @next_mover_mark
          if @next_mover_mark == :x
            next_mark = :o
          else
            next_mark = :x
          end
          prev_pos = [x, y]
          output << TicTacToeNode.new(duped_board, next_mark, prev_pos)
        end
      end
    end
    output
  end
end

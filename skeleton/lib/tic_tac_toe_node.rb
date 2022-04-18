require_relative 'tic_tac_toe'
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  @@POSITIONS = [[0,0],[0,1],[0,2],
                [1,0],[1,1],[1,2],
                [2,0],[2,1],[2,2]]
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if board.winner && board.winner != evaluator
    
    cpu_turn = next_mover_mark == :o
    _children = children

    if cpu_turn
      return _children.all?{|c|c.losing_node?(evaluator)}
    else
      return _children.any?{|c|c.losing_node?(evaluator)}
    end

  end

  def winning_node?(evaluator)
    # return true if board.winner && board.winner == evaluator
    return false if board.winner && board.winner != evaluator
    
    cpu_turn = next_mover_mark == :o
    _children = children

    if cpu_turn
      return _children.any?{|c|c.winning_node?(evaluator)}
    else
      return _children.all?{|c|c.winning_node?(evaluator)}
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empties = @@POSITIONS.select{|p|board.empty?(p)}
    other_mark = (next_mover_mark == :x) ? :o : :x
    empties.map do |pos|
      new_board = board.dup
      new_board[pos] = next_mover_mark
      TicTacToeNode.new(new_board,other_mark,pos)
    end
  end
end

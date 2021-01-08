# frozen_string_literal: true

# Gameboard for tic-tac-toe
class Board
  def initialize
    @empty_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def print_board
    @empty_board.each do |row|
      puts row.join('|')
    end
  end

  def player1_move
    puts 'Player 1, what is your move?'
    @space = gets.to_i

    if @space.between?(1, 3)
      @empty_board[0][@space - 1] = 'X'
    elsif @space.between?(4, 6)
      @empty_board[1][@space - 4] = 'X'
    elsif @space.between?(7, 9)
      @empty_board[2][@space - 7] = 'X'
    end
  end

  def player2_move
    puts 'Player 2, what is your move?'
    @space = gets.to_i - 1

    if @space.between?(1, 3)
      @empty_board[0][@space - 1] = 'O'
    elsif @space.between?(4, 6)
      @empty_board[1][@space - 4] = 'O'
    elsif @space.between?(7, 9)
      @empty_board[2][@space - 7] = 'O'
    end
  end
end

new_board = Board.new
new_board.print_board
new_board.player1_move
new_board.print_board
new_board.player2_move
new_board.print_board

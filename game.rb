# frozen_string_literal: true

# Gameboard for tic-tac-toe
class Board
  def initialize
    @empty_board = [['_', '_', '_'], ['_', '_', '_'], [' ',' ',' ',]]
    @empty_board.each do |row|
      puts row.join('|')
    end
  end
end

new_board = Board.new

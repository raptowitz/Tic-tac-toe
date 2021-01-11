# frozen_string_literal: true

# Gameboard
class Board
  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def print_board
    @board.each do |row|
      puts row.join('|')
    end
  end

  def locate_move
    if @move.between?(1, 3)
      @row = 0
      @column = @move - 1
    elsif @move.between?(4, 6)
      @row = 1
      @column = @move - 4
    elsif @move.between?(7, 9)
      @row = 2
      @column = @move - 7
    end
  end

  def available_space?(move)
    @move = move
    locate_move
    @board[@row][@column].is_a?(Integer)
  end

  def place_move(player_token)
    @player_token = player_token
    @board[@row][@column] = @player_token
  end

  def check_victory?
    row_victory? || column_victory? || diagonol1_victory? || diagonol2_victory?
  end

  def tie?
    @board.flatten.all? { |space| space.is_a?(String) }
  end

  private

  def row_victory?
    @board.any? { |rows| rows.uniq.length == 1 }
  end

  def column_victory?
    i = 0
    while i < 3
      if @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i]
        return true
      end

      i += 1
    end
  end

  def diagonol1_victory?
    @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
  end

  def diagonol2_victory?
    @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
  end
end

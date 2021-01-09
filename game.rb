# frozen_string_literal: true

# Gameboard for tic-tac-toe
class Board
  def initialize
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def print_board
    @board.each do |row|
      puts row.join('|')
    end
  end
end

# Player moves
class Player < Board
  def player_move(player)
    @player = player
    puts "Player #{@player}, what is your move?"
    @space = gets.to_i

    if @space.between?(1, 3)
      @board[0][@space - 1] = @player
    elsif @space.between?(4, 6)
      @board[1][@space - 4] = @player
    elsif @space.between?(7, 9)
      @board[2][@space - 7] = @player
    end
  end
end

# Check victory
class Score < Player
  def play_game
    until check_victory?
      print_board
      player_move('X')
      print_board
      player_move('O')
    end
  end

  def row_victory?
    i = 0
    while i < 3
      if @board[i][0] == @board[i][1] && @board[i][0] == @board[i][2]
        return true
      end

      i += 1
    end
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

  def check_victory?
    row_victory? || column_victory? || diagonol1_victory? || diagonol2_victory?
  end
end

new_game = Score.new
new_game.play_game

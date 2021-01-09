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
    print_board
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
  @victory = false

  def play_game
    until @victory
      player_move('X')
      check_victory
      player_move('O')
      check_victory
    end
  end

  def check_victory
    i = 0
    while i < 3 do
      if @board[i][0] == @board[i][1] && @board[i][0] == @board[i][2]
        @victory = true
        puts 'Victory'
      end
      i += 1
    end
  end
end

new_game = Score.new
new_game.play_game

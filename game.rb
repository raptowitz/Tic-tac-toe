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

  def place_move(player_token)
    @player_token = player_token
    @board[@row][@column] = @player_token
  end

  def available_space?(move)
    @move = move
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
    @board[@row][@column].is_a?(Integer)
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
end

# Players
class Player
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def take_turn
    puts "\nPlayer #{@token}, what is your move?"
    @move = gets.to_i
    until @move >= 1 && @move <= 9
      puts 'Pick a space between 1-9!'
      @move = gets.to_i
    end
    @move
  end
end

# Game
class Game
  def initialize(player1, player2, gameboard)
    @player1 = player1
    @player2 = player2
    @gameboard = gameboard
  end

  def play_game
    until check_victory?
      @gameboard.print_board
      until @gameboard.available_space?(@player1.take_turn)
        puts 'Pick an available space!'
        @player1.take_turn
      end
      @gameboard.place_move(@player1.token)
      @gameboard.print_board
      unless check_victory?
        until @gameboard.available_space?(@player2.take_turn)
          puts 'Pick an available space!'
          @player2.take_turn
        end
        @gameboard.place_move(@player2.token)
      end
    end
    puts "\nVictory!"
  end

  private

  def check_victory?
    @gameboard.row_victory? || @gameboard.column_victory? ||
      @gameboard.diagonol1_victory? || @gameboard.diagonol2_victory?
  end
end

new_game = Game.new(Player.new('X'), Player.new('O'), Board.new)
new_game.play_game

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

  def tie?
    @board.flatten.all? { |space| space.is_a?(String) }
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
    puts "\nGame on!"
    until game_over?
      @gameboard.print_board
      player1_move
      @gameboard.print_board
      break if game_over?

      player2_move
      @gameboard.print_board if game_over?
    end
    display_results
  end

  private

  def player1_move
    @player1_move = @player1.take_turn
    if @gameboard.available_space?(@player1_move)
      @gameboard.place_move(@player1.token)
    else
      until @gameboard.available_space?(@player1_move)
        puts 'Pick an available space!'
        @player1_move = @player1.take_turn
      end
    end
    @gameboard.place_move(@player1.token)
  end

  def player2_move
    @player2_move = @player2.take_turn
    if @gameboard.available_space?(@player2_move)
      @gameboard.place_move(@player2.token)
    else
      until @gameboard.available_space?(@player2_move)
        puts 'Pick an available space!'
        @player2_move = @player2.take_turn
      end
    end
    @gameboard.place_move(@player2.token)
  end

  def check_victory?
    @gameboard.row_victory? || @gameboard.column_victory? ||
      @gameboard.diagonol1_victory? || @gameboard.diagonol2_victory?
  end

  def game_over?
    check_victory? || @gameboard.tie?
  end

  def display_results
    if check_victory?
      puts "\nVictory!"
    else
      puts "\nTie!"
    end
    new_game
  end

  def new_game
    new_game = Game.new(Player.new('X'), Player.new('O'), Board.new)
    new_game.play_game
  end
end

new_game = Game.new(Player.new('X'), Player.new('O'), Board.new)
new_game.play_game

# frozen_string_literal: true

require_relative 'player.rb'
require_relative 'board.rb'

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

  def game_over?
    @gameboard.check_victory? || @gameboard.tie?
  end

  def display_results
    if @gameboard.check_victory?
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

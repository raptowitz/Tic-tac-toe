# frozen_string_literal: true

# Game
class Game
  attr_reader :play_again

  def initialize(player1 = Player.new('X'), player2 = Player.new('O'), board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @play_again = true
  end

  def play_game
    puts "\nGame on!"
    until game_over?
      @board.print_board
      player_move(@player1)
      @board.print_board
      break if game_over?

      player_move(@player2)
      @board.print_board if game_over?
    end
    display_results
  end

  def player_move(player)
    move = player.take_turn
    place_move(player, move, player.token)
  end

  def place_move(player, move, token)
    until @board.available_space?(move)
      puts 'Pick an available space!'
      move = player.take_turn
    end
    @board.place_move(token)
  end

  def game_over?
    @board.check_victory? || @board.tie?
  end

  def display_results
    if @board.check_victory?
      puts "\nVictory!"
    else
      puts "\nTie!"
    end
    new_game
  end

  def new_game
    puts 'Play again? (y/n)'
    return unless gets.chomp == 'n'

    @play_again = false
    puts 'Thanks for playing!'
  end
end

# frozen_string_literal: true

# Game
class Game
  def initialize(player1 = Player.new('X'), player2 = Player.new('O'), gameboard = Board.new)
    @player1 = player1
    @player2 = player2
    @gameboard = gameboard
  end

  def play_game
    puts "\nGame on!"
    until game_over?
      @gameboard.print_board
      player_move(@player1)
      @gameboard.print_board
      break if game_over?

      player_move(@player2)
      @gameboard.print_board if game_over?
    end
    display_results
  end

  def player_move(player)
    move = player.take_turn
    place_move(player, move, player.token)
  end

  def place_move(player, move, token)
    until @gameboard.available_space?(move)
      puts 'Pick an available space!'
      move = player.take_turn
    end
    @gameboard.place_move(token)
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
    puts 'Play again? (y/n)'
    if gets.chomp == 'y'
      new_game = Game.new(Player.new('X'), Player.new('O'), Board.new)
      new_game.play_game
    else
      puts 'Thanks for playing!'
    end
  end
end


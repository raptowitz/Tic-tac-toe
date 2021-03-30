# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'game'

new_game = Game.new(Player.new('X'), Player.new('O'), Board.new)
new_game.play_game

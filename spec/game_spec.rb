# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#play_game' do
    # Looping Script Method -> test the behavior of the method
    # play_game will stop looping when game is over
    subject(:end_game) { described_class.new }

    context 'when the game is over' do
      before do
        allow(end_game).to receive(:puts).with("\nGame on!")
        allow(end_game).to receive(:game_over?).and_return true
      end

      it 'stops loop and displays results' do
        expect(end_game).to receive(:display_results)
        end_game.play_game
      end
    end
  end

  describe '#player_move' do
    # Method with Outgoing Command -> Test that a message is sent
    subject(:game) { described_class.new }
    let(:player) { instance_double(Player, token: 'X') }

    before do
      allow(game).to receive(:place_move)
    end

    it 'sends take turn to player' do
      expect(player).to receive(:take_turn)
      game.player_move(player)
    end
  end

  describe '#place_move' do
    # Method with Outgoing Command -> Test that a message is sent
    let(:player) { instance_double(Player, token: 'O') }
    let(:board) { instance_double(Board) }
    subject(:new_game) { described_class.new(player, player, board) }

    context 'when a board space is available' do
      before do
        allow(board).to receive(:available_space?).and_return true
      end

      it 'sends place move to board' do
        expect(board).to receive(:place_move).with(player.token)
        new_game.place_move(player, 3, player.token)
      end
    end

    context 'when a user picks a taken space once, then an available space' do
      before do
        allow(board).to receive(:available_space?).and_return(false, true)
        allow(player).to receive(:take_turn)
        allow(board).to receive(:place_move)
      end

      it 'completes loop and displays instructions once' do
        instructions = 'Pick an available space!'
        expect(new_game).to receive(:puts).with(instructions).once
        new_game.place_move(player, 3, player.token)
      end
    end
  end
end

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
    subject(:new_game) { described_class.new }
    let(:player) { instance_double(Player, token: 'X') }

    before do
      allow(new_game).to receive(:check_available_space)
    end

    it 'sends take turn to player' do
      expect(player).to receive(:take_turn)
      new_game.player_move(player)
    end
  end
end

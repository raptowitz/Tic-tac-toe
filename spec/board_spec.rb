# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Board do
  describe '#check_victory?' do
    # Query Method -> Test the return value
    subject(:end_game) { described_class.new }

    context 'when the game is over' do
      before do
        allow(end_game).to receive(:row_victory?).and_return true
        allow(end_game).to receive(:column_victory?).and_return false
        allow(end_game).to receive(:diagonal1_victory?).and_return false
        allow(end_game).to receive(:diagonal2_victory?).and_return false
      end

      it 'returns true' do
        output = end_game.check_victory?
        expect(output).to be true
      end
    end
  end
end
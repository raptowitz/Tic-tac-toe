# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Board do
  describe '#tie?' do
    # Query Method -> Test the return value
    subject(:tie_game) { described_class.new([%w[X O X], %w[O X O], %w[O X O]]) }

    context 'when the game is a tie' do
      it 'returns true' do
        output = tie_game.tie?
        expect(output).to be true
      end
    end

    subject(:mid_game) { described_class.new([%w[X O X], [4, 5, 6], %w[O X O]]) }

    context 'when the game is not a tie' do
      it 'returns false' do
        output = mid_game.tie?
        expect(output).to be false
      end
    end
  end

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

    context 'when the game is not over' do
      before do
        allow(end_game).to receive(:row_victory?).and_return false
        allow(end_game).to receive(:column_victory?).and_return false
        allow(end_game).to receive(:diagonal1_victory?).and_return false
        allow(end_game).to receive(:diagonal2_victory?).and_return false
      end

      it 'returns false' do
        output = end_game.check_victory?
        expect(output).to be false
      end
    end
  end
end

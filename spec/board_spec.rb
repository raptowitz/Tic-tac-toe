# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Board do
  describe '#available_space?' do
    # Query Method -> Test the return value
    subject(:new_game) { described_class.new }

    context 'when the game board space is available' do
      it 'returns true' do
        output = new_game.available_space?(1)
        expect(output).to be true
      end
    end

    subject(:mid_game) { described_class.new([%w[x o x], [4, 5, 6], [7, 8, 9]]) }

    context 'when the game board space is taken' do
      it 'returns false' do
        output = mid_game.available_space?(1)
        expect(output).to be false
      end
    end
  end

  describe '#place_move' do
    # Command Method -> Test the change in the observable state
    subject(:game) { described_class.new }

    it 'places a move on the board' do
      expect { game.place_move('X', 0, 0) }.to change { (game.instance_variable_get(:@board)[0][0]) }.from(1).to('X')
    end
  end

  describe '#check_victory?' do
    # Query Method -> Test the return value
    subject(:top_win) { described_class.new([%w[x x x], [4, 5, 6], [7, 8, 9]]) }

    context 'when the game has been won' do
      it 'returns true' do
        output = top_win.check_victory?
        expect(output).to be true
      end
    end

    subject(:mid_game) { described_class.new([%w[x o x], [4, 5, 6], [7, 8, 9]]) }

    context 'when the game is mid game' do
      it 'returns false' do
        output = mid_game.check_victory?
        expect(output).to be false
      end
    end
  end

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
end
# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#take_turn' do
    # Looping Script Method -> Test the behavior of the method
    subject(:player) { described_class.new('X') }

    context 'when user picks a space on the board' do
      before do
        valid_input = 3
        allow(player).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display instructions' do
        instructions = 'Pick a space between 1-9!'
        expect(player).not_to receive(:puts).with(instructions)
        player.take_turn
      end
    end

    context 'when user inputs an invalid space once, then a valid space' do
      before do
        invalid_input = 12
        valid_input = 3
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        allow(player).to receive(:puts).with("\nPlayer X, what is your move?")
      end

      it 'completes loop and displays instructions once' do
        instructions = 'Pick a space between 1-9!'
        expect(player).to receive(:puts).with(instructions).once
        player.take_turn
      end
    end

    context 'when user inputs two invalid spaces, then a valid space' do
      before do
        invalid_input = 12
        symbol = '$'
        valid_input = 3
        allow(player).to receive(:gets).and_return(invalid_input, symbol, valid_input)
        allow(player).to receive(:puts).with("\nPlayer X, what is your move?")
      end

      it 'completes loop and displays instructions twice' do
        instructions = 'Pick a space between 1-9!'
        expect(player).to receive(:puts).with(instructions).twice
        player.take_turn
      end
    end
  end
end

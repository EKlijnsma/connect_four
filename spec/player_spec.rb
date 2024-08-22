# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new }

  describe '#verify_input' do
    context 'when given a valid input as argument' do
      it 'returns valid input' do
        user_input = '2'
        expect(player.verify_input(user_input)).to eq('2')
      end
    end

    context 'when given invalid input as argument' do
      it 'returns nil' do
        user_input = '12'
        expect(player.verify_input(user_input)).to be_nil
      end
    end
  end

  describe '#player_turn' do
    context 'when user input is valid' do
      it 'returns valid input and does not display error message' do
        valid_input = '2'
        allow(player).to receive(:verify_input).and_return(valid_input)
        expect(player).not_to receive(:puts).with('Input error!')
        result = player.player_turn
        expect(result).to(eq(valid_input))
      end
    end
    context 'when user inputs an incorrect value once, then a valid input' do
      it 'returns valid input and displays error message once' do
        invalid_input = '12'
        valid_input = '2'
        allow(player).to receive(:verify_input).and_return(invalid_input, valid_input)
        expect(player).to receive(:puts).with('Input error!').once
        result = player.player_turn
        expect(result).to eq(valid_input)
      end
    end
    context 'when user inputs two incorrect values, then a valid input' do
      it 'returns valid input and displays error message twice' do
        invalid_input = 'string'
        invalid_number = '12'
        valid_input = '2'
        allow(player).to receive(:verify_input).and_return(invalid_input, invalid_number, valid_input)
        expect(player).to receive(:puts).with('Input error!').twice
        result = player.player_turn
        expect(result).to eq(valid_input)
      end
    end
  end
end

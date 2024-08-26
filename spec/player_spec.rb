# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  let(:symbol) { 'X' }
  subject(:player) { described_class.new(symbol) }

  describe '#initialize' do
    it 'initializes with the given player symbol' do
      expect(player.symbol).to eq(symbol)
    end
  end

  describe '#verify_input' do
    it 'returns true for valid numbers' do
      expect(player.verify_input('0')).to be true
    end

    it 'returns false for invalid numbers' do
      expect(player.verify_input('9')).to be false
    end

    it 'returns false for string inputs' do
      expect(player.verify_input('string')).to be false
    end
  end

  describe '#get_move' do
    it 'prompts for user input' do
      expect(player).to receive(:get_input)
    end

    it 'verifies the user input' do
      expect(player).to receive(:verify_input)
    end

    it 'returns valid user input' do
      allow(player).to receive(:get_input).and_return('2')
      allow(player).to receive(:verify_input).and_return(2)
      expect(player.get_move).to eq(2)
    end
  end
end

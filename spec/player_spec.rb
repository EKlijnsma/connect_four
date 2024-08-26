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
      allow(player).to receive(:get_input).and_return('2')
      expect(player).to receive(:get_input)
      player.get_move
    end

    it 'verifies the user input' do
      allow(player).to receive(:get_input).and_return('2')
      allow(player).to receive(:verify_input).and_return(true)
      expect(player).to receive(:verify_input)
      player.get_move
    end

    it 'loops 3 times when given invalid user input' do
      allow(player).to receive(:get_input).and_return('7', 'string', '2')
      allow(player).to receive(:verify_input).and_return(false, false, true)
      expect(player).to receive(:get_input).exactly(3).times
      player.get_move
    end

    it 'returns valid user input' do
      allow(player).to receive(:get_input).and_return('2')
      allow(player).to receive(:verify_input).and_return(true)
      expect(player.get_move).to eq(2)
    end
  end
end

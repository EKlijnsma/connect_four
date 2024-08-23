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
end

# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/cage'

describe Game do
  let(:player1) { Player.new('X') }
  let(:player2) { Player.new('O') }
  let(:cage) { Cage.new }
  let(:game) { Game.new(cage, player1, player2) }

  describe '#initialize' do
    it 'initializes with two players' do
      expect(game.player1).to eq(player1)
      expect(game.player2).to eq(player2)
    end

    it 'initializes with a cage' do
      expect(game.cage).to eq(cage)
    end

    it 'sets the current player to player1' do
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#make_move' do
    it 'allows a player to drop a token in a column' do
      game.make_move(0)
      expect(game.state[0][0]).not_to be_nil
    end

    it 'raises an error if the column is full' do
      6.times { game.make_move(0) }
      expect { game.make_move(0) }.to raise_error('Column is full')
    end

    it 'switches the current player after a valid move' do
      game.make_move(0)
      expect(game.current_player).to eq(player2)
    end
  end
end

# rubocop:enable Metrics/BlockLength

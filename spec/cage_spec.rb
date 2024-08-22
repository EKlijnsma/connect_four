# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/cage'

describe Cage do
  subject(:cage) { described_class.new }

  describe '#initialize' do
    context 'when the cage is initialized' do
      xit 'has 7 columns' do
        expect(cage.state.size).to eq(7)
      end

      xit 'has 6 rows' do
        cage.stage.each do |column|
          expect(column.size).to eq(6)
        end
      end

      xit 'has all nil values' do
        cage.stage.each do |column|
          expect(column).to all(be_nil)
        end
      end
    end
  end

  describe '#winner?' do
    # Helper to create a grid with all cells initialized to nil
    let(:grid) { Array.new(7) { Array.new(6, nil) } }

    context 'when the cage is empty' do
      xit 'does not detect a win' do
        expect(cage).not_to be_winner
      end
    end

    context 'when the cage is partly filled' do
      xit 'correctly returns no win' do
        grid[0][0] = 'X'
        cage.state = grid
        expect(cage).not_to be_winner
      end
      xit 'detects a horizontal win' do
        4.times { |i| grid[i][0] = 'X' }
        cage.state = grid
        expect(cage).to be_winner
      end
      xit 'detects a vertical win' do
        4.times { |i| grid[0][i] = 'X' }
        cage.state = grid
        expect(cage).to be_winner
      end
      xit 'detects a diagonal win' do
        4.times { |i| grid[i][i] = 'X' }
        cage.state = grid
        expect(cage).to be_winner
      end
    end
  end
end

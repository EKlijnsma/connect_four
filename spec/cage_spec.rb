# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/cage'

describe Cage do
  subject(:cage) { described_class.new }
  let(:grid) { Array.new(7) { Array.new(6, nil) } }

  describe '#initialize' do
    context 'when the cage is initialized' do
      it 'has 7 columns' do
        expect(cage.state.size).to eq(7)
      end

      it 'has 6 rows' do
        cage.state.each do |column|
          expect(column.size).to eq(6)
        end
      end

      it 'has all nil values' do
        cage.state.each do |column|
          expect(column).to all(be_nil)
        end
      end
    end
  end

  describe '#vertical_win?' do
    context 'when the cage is empty' do
      it 'does not detect a win' do
        expect(cage).not_to be_vertical_win
      end
    end

    context 'when the cage is not empty' do
      it 'correctly detects no win' do
        grid[0][0] = 'X'
        cage.state = grid
        expect(cage).not_to be_vertical_win
      end

      it 'correctly detects a vertical win' do
        4.times { |i| grid[0][i] = 'X' }
        cage.state = grid
        expect(cage).to be_vertical_win
      end
    end
  end

  describe '#diagonal_win?' do
    context 'when the cage is empty' do
      it 'does not detect a win' do
        expect(cage).not_to be_diagonal_win
      end
    end

    context 'when the cage is not empty' do
      it 'correctly detects no win' do
        grid[0][0] = 'X'
        cage.state = grid
        expect(cage).not_to be_diagonal_win
      end

      it 'correctly detects a diagonal win' do
        4.times { |i| grid[i][i] = 'X' }
        cage.state = grid
        expect(cage).to be_diagonal_win
      end
    end
  end

  describe '#horizontal_win?' do
    context 'when the cage is empty' do
      it 'does not detect a win' do
        expect(cage).not_to be_horizontal_win
      end
    end

    context 'when the cage is not empty' do
      it 'correctly detects no win' do
        grid[0][0] = 'X'
        cage.state = grid
        expect(cage).not_to be_horizontal_win
      end

      it 'correctly detects a horizontal win' do
        4.times { |i| grid[i][0] = 'X' }
        cage.state = grid
        expect(cage).to be_horizontal_win
      end
    end
  end

  describe '#winner?' do
    context 'when no win' do
      xit 'detects no win' do
      end
    end

    context 'when horizontal win' do
      xit 'detects a win' do
      end
    end

    context 'when vertical win' do
      xit 'detects a win' do
      end
    end

    context 'when diagonal win' do
      xit 'detects a win' do
      end
    end
  end
end

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

  describe '#full_column?' do
    it 'returns true when the column is full' do
    end

    it 'returns false when column is partially filled' do
    end

    it 'returns false when column is empty' do
    end
  end

  describe '#place_token' do
    context 'when given a valid column' do
      it 'places a token correctly in an empty column' do
      end

      it 'places a token correctly in a non-empty column' do
      end
    end

    context 'when given an invalid column' do
      it 'raises an error when the column number is incorrect' do
      end

      it 'raises an error when the given column is full' do
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

      it 'correctly detects a "/" diagonal win' do
        4.times { |i| grid[i][i] = 'X' }
        cage.state = grid
        expect(cage).to be_diagonal_win
      end

      it 'correctly detects a "\" diagonal win' do
        4.times { |i| grid[i][3 - i] = 'X' }
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
      it 'detects no win' do
        allow(cage).to receive(:horizontal_win?).and_return(false)
        allow(cage).to receive(:vertical_win?).and_return(false)
        allow(cage).to receive(:diagonal_win?).and_return(false)
        expect(cage).not_to be_winner
      end
    end

    context 'when horizontal win' do
      it 'detects a win' do
        allow(cage).to receive(:horizontal_win?).and_return(true)
        allow(cage).to receive(:vertical_win?).and_return(false)
        allow(cage).to receive(:diagonal_win?).and_return(false)
        expect(cage).to be_winner
      end
    end

    context 'when vertical win' do
      it 'detects a win' do
        allow(cage).to receive(:horizontal_win?).and_return(false)
        allow(cage).to receive(:vertical_win?).and_return(true)
        allow(cage).to receive(:diagonal_win?).and_return(false)
        expect(cage).to be_winner
      end
    end

    context 'when diagonal win' do
      it 'detects a win' do
        allow(cage).to receive(:horizontal_win?).and_return(false)
        allow(cage).to receive(:vertical_win?).and_return(false)
        allow(cage).to receive(:diagonal_win?).and_return(true)
        expect(cage).to be_winner
      end
    end
  end

  describe '#full_board?' do
    it 'returns true when the board is full' do
    end

    it 'returns false when board is partially filled' do
    end

    it 'returns false when board is empty' do
    end
  end
end

# rubocop:enable Metrics/BlockLength

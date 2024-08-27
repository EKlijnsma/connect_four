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

  describe '#play' do
    before do
      allow(cage).to receive(:puts)
      allow(game).to receive(:puts)
    end

    it 'starts the game loop' do
      # Mock or stub methods if necessary
      allow(player1).to receive(:get_input).and_return('0')
      allow(player2).to receive(:get_input).and_return('0')
      allow(game).to receive(:game_over?).and_return(true)

      expect(game).to receive(:make_move)
      # Ensure the game loop initializes and runs
      game.play
    end

    it 'detects a win condition' do
      allow(player1).to receive(:get_move).and_return(0, 0, 0, 0)
      allow(player2).to receive(:get_move).and_return(1, 1, 1, 1)

      expect(game).to receive(:announce_winner)

      game.play
    end

    it 'detects a draw condition' do
      allow(player1).to receive(:get_move).and_return(0, 0, 0, 1, 1, 1, 2, 2, 2, 6, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6)
      allow(player2).to receive(:get_move).and_return(0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6)

      expect(game).to receive(:announce_draw)

      game.play
    end

    it 'switches turns after a move when the game is not over' do
      allow(player1).to receive(:get_move).and_return(0)
      allow(player2).to receive(:get_move).and_return(0)
      allow(game).to receive(:game_over?).and_return(false, true)

      expect(game).to receive(:switch_turns).once

      game.play
    end

    it 'does not switch turns after a move when the game is over' do
      allow(player1).to receive(:get_move).and_return(0)
      allow(player2).to receive(:get_move).and_return(0)
      allow(game).to receive(:game_over?).and_return(true)

      expect(game).not_to receive(:switch_turns)

      game.play
    end
  end

  describe '#make_move' do
    it 'places token correctly in the cage' do
      game.current_player = player1
      symbol = 'X'
      column = 0
      expect(cage).to receive(:update_state).with(column, symbol)
      game.make_move(column)
    end

    it 'raises an error when column is full' do
      6.times { game.make_move(0) }
      expect { game.make_move(0) }.to raise_error(InvalidMoveError)
    end

    it 'raises error when input is invalid number' do
      expect { game.make_move(9) }.to raise_error(InvalidMoveError)
    end

    it 'raises error when input is invalid type' do
      expect { game.make_move('string') }.to raise_error(InvalidMoveError)
    end
  end

  describe '#switch_turns' do
    it 'switches turn from player 1 to player 2' do
      game.current_player = player1
      game.switch_turns
      expect(game.current_player).to eq(player2)
    end

    it 'switches turn from player 2 to player 1' do
      game.current_player = player2
      game.switch_turns
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#winner?' do
    it 'returns true if there is a winner' do
      allow(cage).to receive(:winner?).and_return(true)
      expect(game).to be_winner
    end
    it 'returns false if there is not a winner' do
      allow(cage).to receive(:winner?).and_return(false)
      expect(game).not_to be_winner
    end
    it 'delegates win checking to the Cage class' do
      expect(cage).to receive(:winner?)
      game.winner?
    end
  end

  describe '#draw?' do
    it 'returns true if game is drawn' do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full_board?).and_return(true)
      expect(game).to be_draw
    end

    it 'returns false if game is not drawn' do
      allow(cage).to receive(:winner?).and_return(false)
      allow(cage).to receive(:full_board?).and_return(false)
      expect(game).not_to be_draw
    end
    it 'delegates draw checking to the Cage class' do
      expect(cage).to receive(:full_board?)
      game.draw?
    end
  end

  describe '#game_over?' do
    it 'returns true if there is a winner' do
      allow(game).to receive(:winner?).and_return(true)
      expect(game).to be_game_over
    end

    it 'returns true if the game is drawn' do
      allow(game).to receive(:draw?).and_return(true)
      expect(game).to be_game_over
    end

    it 'returns false if game is not over' do
      allow(game).to receive(:winner?).and_return(false)
      allow(game).to receive(:draw?).and_return(false)
      expect(game).not_to be_game_over
    end
  end
end

# rubocop:enable Metrics/BlockLength

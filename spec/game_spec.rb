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
    it 'starts the game loop' do
      # Mock or stub methods if necessary
      expect(game).to receive(:make_move)
      expect(game).to receive(:winner?)
      expect(game).to receive(:draw?)
      expect(game).to receive(:switch_turns)
      # Ensure the game loop initializes and runs
      game.play
    end

    it 'detects a win condition' do
      # Simulate moves that lead to a win
      allow(game).to receive(:make_move).with(0).and_return(nil)
      allow(game).to receive(:draw?).and_return(false)
      allow(game).to receive(:switch_turns).and_return(player1)

      # Ensure the game correctly detects the win and ends
      expect(game).to receive(:winner?).and_return(false, false, false, true)
      game.play
    end

    xit 'detects a draw condition' do
      # Simulate moves that lead to a draw

      # Ensure the game correctly detects the draw and ends
    end

    it 'ends the game when game is won' do
      # Simulate a win or draw and ensure the game ends
      allow(game).to receive(:make_move).and_return(nil)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:draw?).and_return(false)

      expect(game).to receive(:game_over?).and_return(true)
      # Ensure the game loop initializes and runs
      game.play
    end

    it 'ends the game when game is drawn' do
      # Simulate a win or draw and ensure the game ends
      allow(game).to receive(:make_move).and_return(nil)
      allow(game).to receive(:winner?).and_return(false)
      allow(game).to receive(:draw?).and_return(true)

      expect(game).to receive(:game_over?).and_return(true)
      # Ensure the game loop initializes and runs
      game.play
    end

    it 'switches turns after a move when the game is not over' do
      # Simulate moves and verify turns are switched correctly
      allow(game).to receive(:make_move).and_return(nil)
      allow(game).to receive(:winner?).and_return(false)
      allow(game).to receive(:draw?).and_return(false)

      expect(game).to receive(:switch_turns)
      game.play
    end

    it 'does not switch turns after a move when the game is over' do
      # Simulate a game-ending condition and ensure turns are not switched
      allow(game).to receive(:make_move).and_return(nil)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:draw?).and_return(false)

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

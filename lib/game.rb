# frozen_string_literal: true

require_relative 'invalid_move_error'

class Game
  attr_accessor :cage, :player1, :player2, :current_player

  def initialize(cage = Cage.new, player1 = Player.new('X'), player2 = Player.new('O'))
    @cage = cage
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def make_move(col)
    raise InvalidMoveError if col.class != Integer

    cage.update_state(col, current_player.symbol)
    switch_turns
  end

  def play
    while true
      col = current_player.get_move
      make_move(col)
      break if game_over?

      switch_turns
    end
  end

  def switch_turns
    @current_player = (current_player == player1 ? player2 : player1)
  end

  def winner?
    cage.winner?
  end

  def draw?
    cage.full_board? && !cage.winner?
  end

  def game_over?
    winner? || draw?
  end
end

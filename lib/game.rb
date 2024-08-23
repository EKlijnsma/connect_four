# frozen_string_literal: true

class Game
  attr_accessor :cage, :player1, :player2, :current_player

  def initialize(cage = Cage.new, player1 = Player.new('X'), player2 = Player.new('O'))
    @cage = cage
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def make_move(col)
    column = cage.state[col]
    column.each do |row|
      next unless row.nil?

      cage.update(col, row, current_player.symbol)
      switch_players
      break
    end
    raise 'Column is full'
  end

  def switch_players
    # TODO
  end
end

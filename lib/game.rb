# frozen_string_literal: true

require_relative 'invalid_move_error'

class Game
  attr_accessor :cage, :player1, :player2, :current_player

  def initialize(cage = Cage.new, player1 = Player.new('🔴'), player2 = Player.new('🟡'))
    @cage = cage
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def make_move(col)
    raise InvalidMoveError if col.class != Integer

    cage.update_state(col, current_player.symbol)
  end

  def play
    welcome
    cage.print_board
    loop do
      col = current_player.get_move
      begin
        make_move(col)
      rescue InvalidMoveError
        puts 'Invalid move'
        next
      end
      cage.print_board
      break if game_over?

      switch_turns
    end
    draw? ? announce_draw : announce_winner
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

  def welcome
    puts 'WELCOME TO CONNECT FOUR!'
    puts "It's player 1 with the #{player1.symbol} tokens vs player 2 with the #{player2.symbol} tokens"
    puts 'Use the numbers above each column to enter your move'
    puts "Let's start...."
  end

  def announce_draw
    puts "Well played on both sides. The game ended in a draw!\nSee you next time, goodbye!"
  end

  def announce_winner
    puts "Good game!. There are four #{current_player.symbol} tokens connected.\nYOU WON!!\nSee you next time, goodbye!"
  end
end

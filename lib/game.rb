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
    puts "\n====WELCOME TO CONNECT FOUR!====\n"
    sleep(1)
    puts "In this game it's #{player1.symbol} vs #{player2.symbol}!"
    sleep(2)
    puts "\nYou each take turns placing your token in the cage below.\nUse the numbers above each column to enter your move."
    sleep(4)
    print "Let's start in "
    countdown
  end

  def countdown(start = 3, delay = 0.5)
    start.downto(1) do |i|
      print "#{i}"
      3.times do
        print '.'
        sleep(delay)
      end
      sleep(delay)
    end
  end

  def announce_draw
    puts "\nWell played on both sides. The game ended in a draw!\nSee you next time, goodbye!"
  end

  def announce_winner
    puts "\nGood game -> #{current_player.symbol * 4}.\nYOU WON!!\nSee you next time, goodbye!\n\n"
  end
end

# frozen_string_literal: true

class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def get_move
    move = nil
    loop do
      move = get_input
      break if verify_input(move)
    end
    move.to_i
  end

  def get_input
    puts "Enter a column number to put your #{symbol} token:"
    gets.chomp
  end

  def verify_input(input)
    valid_moves = %w[0 1 2 3 4 5 6]
    valid_moves.include?(input)
  end
end

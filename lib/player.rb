class Player
  def initialize
  end

  def player_input
    gets.chomp
  end

  def verify_input(input)
    input if input.match?(/^[0-6]$/)
  end

  def player_turn
    move = verify_input(player_input)
    while move.nil?
      puts 'Input error!'
      move = verify_input(player_input)
    end
    move
  end
end

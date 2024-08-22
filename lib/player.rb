class Player
  def initialize
  end

  def verify_input(input)
    input if input.match?(/^[0-7]$/)
  end
end

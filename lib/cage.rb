# frozen_string_literal: true

require_relative 'invalid_move_error'

class Cage
  attr_accessor :state

  def initialize
    @state = Array.new(7) { Array.new(6, nil) }
  end

  def vertical_win?
    state.each do |col|
      3.times do |i|
        # For all 3 win positions, check the unique items.
        unique_items = col[i, 4].uniq
        # If there is exactly 1 which is not nil, we have a winner
        # unique_items[0] will return a falsey value if it is nil
        return true if unique_items.size == 1 && unique_items[0]
      end
    end
    false
  end

  def horizontal_win?
    # swap rows and columns
    transposed = state.transpose
    transposed.each do |row|
      4.times do |i|
        # For all 4 win positions check the unique items
        unique_items = row[i, 4].uniq
        # If there is exactly 1 which is not nil, we have a winner
        # unique_items[0] will return a falsey value if it is nil
        return true if unique_items.size == 1 && unique_items[0]
      end
    end
    false
  end

  def diagonal_win?
    # Check for bottom-left to top-right diagonals (/)
    # which can start in columns 0 to 3 and rows 0 to 2
    (0..3).each do |col|
      (0..2).each { |row| return true if check_diagonal(col, row, 1, 1) }
    end

    # Check for bottom-right to top-left diagonals (\)
    # which can start in columns 3 to 6 and rows 0 to 2
    (3..6).each do |col|
      (0..2).each { |row| return true if check_diagonal(col, row, -1, 1) }
    end
    false
  end

  def check_diagonal(start_col, start_row, col_step, row_step)
    items = []
    4.times do |i|
      items << state[start_col + (i * col_step)][start_row + (i * row_step)]
    end
    unique_items = items.uniq
    unique_items.size == 1 && unique_items[0]
  end

  def winner?
    vertical_win? || horizontal_win? || diagonal_win?
  end

  def full_column?(col)
    !state[col][-1].nil?
  end

  def update_state(col, symbol)
    raise InvalidMoveError unless col.between?(0, 6)

    (0..6).each do |row|
      if state[col][row].nil?
        state[col][row] = symbol
        return state
      end
    end
    raise InvalidMoveError
  end

  def full_board?
    !state.flatten.include?(nil)
  end

  def print_row(row)
    string = '|'
    row.each do |token|
      string += token.nil? ? '    |' : " #{token} |"
    end
    puts string
  end

  def print_bar
    puts '=' * 36
  end

  def print_column_picker
    string = ''
    (0..6).each { |i| string += "  #{i}  " }
    puts string
    puts '  ⇓  ' * 7
  end

  def print_board(board = state)
    print_column_picker
    print_bar
    board.transpose.reverse.each do |row|
      print_row(row)
      print_bar
    end
  end
end

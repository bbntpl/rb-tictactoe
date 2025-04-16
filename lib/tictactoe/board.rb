# frozen_string_literal: true

# Board is a class that contain components related to tictactoe board such as the
# symbols to use to mark the grid with and stores current mark
# to be used for board update.
class Board
  BOARD_MARKS = %w[X O].freeze
  BOARD_SIZE = 3
  CURRENT_MARK = 'X'

  attr_accessor :board, :current_mark

  def initialize
    @board = create_board_as_array
    @current_mark = CURRENT_MARK
  end

  def self.total_grids
    BOARD_SIZE * BOARD_SIZE
  end

  def print_board
    print("\n")

    board.each_with_index do |row, i|
      row.each_with_index do |val, j|
        grid_num = indices_to_grid_num([i, j])

        print_row(grid_num, val, j)
      end
    end

    print("\n")
  end

  def reset_board
    @board = create_board_as_array
  end

  def update_board(grid_n)
    i, j = get_board_indices(grid_n)

    if grid_marked?([i, j])
      puts 'Marked already. Try again!'
    else
      board[i][j] = current_mark
    end
  end

  # Check if board has winner based on valid marked row
  def board_has_winner?
    winning_conditions.any? do |row|
      current_grid = row[0]
      increments = row[1]
      grid_index = current_grid - 1

      return true if marked_row(grid_index, increments)
    end
  end

  def board_filled?
    board.flatten.all? { |grid| !grid.nil? }
  end

  private

  # Check if each grid contains the same mark
  def marked_row(grid_index, increments)
    flattened_board = board.flatten
    increments.any? do |increment|
      marks = [
        flattened_board[grid_index],
        flattened_board[grid_index + increment],
        flattened_board[grid_index + (increment * 2)]
      ]
      unique = marks.uniq
      unique.size == 1 && unique.first
    end
  end

  def winning_conditions
    # 1st el: refers to the first grid number to check
    # 2nd el: refers to the set of incrementers to access the remaining grids
    # For example, for grid number 1 it'll be
    # (1,2,3), (1,4,7) (1,5,9) and so on....
    [
      [1, [1, 3, 4]],
      [2, [3]],
      [3, [2, 3]],
      [4, [1]],
      [7, [1]]
    ]
  end

  # Print the grid number or the mark
  def print_row(grid_num, val, inner_index)
    colors = {
      'X' => "\e[31m#{val}\e[0m",
      'O' => "\e[32m#{val}\e[0m"
    }

    print('|')
    print(val.nil? ? grid_num : colors[val] || val)
    print("|\n") if inner_index == BOARD_SIZE - 1
  end

  # Convert outer & inner indices to grid label number of board
  def indices_to_grid_num(indices)
    i, j = indices
    size = BOARD_SIZE

    (j + 1) + (i * size)
  end

  # Check if the grid is already marked by either X or O
  def grid_marked?(board_indices)
    i, j = board_indices

    BOARD_MARKS.any? { |mark| board[i][j] == mark }
  end

  # Convert the grid number to outer/inner indices to reference grid
  def get_board_indices(grid_n)
    size = BOARD_SIZE

    i = ((grid_n + size - 1) / size) - 1
    j = (grid_n - 1) % size

    [i, j]
  end

  def create_board_as_array
    Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end
end

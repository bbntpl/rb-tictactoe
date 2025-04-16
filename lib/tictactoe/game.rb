# frozen_string_literal: true

# Game class contains the components that makes up the tictactoe game
# such as two players and a gameboard
class Game
  GAME_START = false
  attr_reader :player_one, :player_two, :board, :in_session

  def initialize(player_one, player_two, board)
    @in_session = GAME_START
    @player_one = player_one
    @player_two = player_two
    @board = board
  end

  def start
    @in_session = true
  end

  def print_scoreboard
    p1 = player_one
    p2 = player_two

    puts "#{p1.name} (#{p1.score} - #{p2.score}) #{p2.name}"
  end

  def show_board
    board.print_board
  end

  def current_player
    player_one.mark == board.current_mark ? player_one : player_two
  end

  def player_mark(grid_n)
    board.update_board(grid_n)

    if board.board_has_winner?
      increment_player_score
      end_game
    else
      board.board_filled? ? end_game : switch_turn
    end
  end

  def get_player_by_mark(mark)
    mark == 'X' ? player_one : player_two
  end

  def increment_player_score
    player = get_player_by_mark(board.current_mark)
    player.score += 1
  end

  def switch_turn
    board.current_mark = board.current_mark == 'X' ? 'O' : 'X'
  end

  def end_game
    @in_session = false
  end
end

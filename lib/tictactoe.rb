# frozen_string_literal: true

# Tictactoe is a module that contains actions to call from game called tictactoe
module Tictactoe
  # Convert stringified number to an integer
  def self.player_input_to_num(name, mark)
    print("#{name}'s turn (#{mark}): ")

    validate_player_input(gets.chomp)
  end

  def self.start_game(game)
    game.start

    while game.in_session
      game.show_board
      p = game.current_player

      grid_num = player_input_to_num(p.name, p.mark)

      game.player_mark(grid_num)
    end

    display_result(game)
    ask_to_restart_game(game)
  end

  def self.display_result(game)
    game.print_scoreboard
    game.show_board
  end

  def self.ask_to_restart_game(game)
    puts 'Would you like to play again (yes/no)?'
    response = gets.chomp.downcase

    if %w[yes y].any? { |r| r == response }
      game.board.reset_board

      start_game(game)
    else
      puts 'The game has ended.'
    end

    print("Game result: \n#{game.print_scoreboard}")
  end

  def self.validate_player_input(input)
    loop do
      input = Integer(input)
      break if input.between?(1, Board.total_grids)

      print("Check the board above. #{guide_message} Try again: ")
      input = gets.chomp
    rescue ArgumentError
      print("#{guide_message}: ")
      input = gets.chomp
    end

    input
  end

  def self.guide_message
    'You must pick between grid #1-9.'
  end
end

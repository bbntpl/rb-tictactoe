# frozen_string_literal: true

# TTT Pseudocode:
#
# Board, initially:
# |1|2|3|
# |4|5|6|
# |7|8|9|
#
# Board, eventually:
# |x|2|x|
# |o|x|o| Player 1 wins!
# |x|8|o|
#
# 1. Create the board and ask player 1 for input (1-9)
# 2. Ask Player 1 for input (1-9)
# 3. Get current player input
# 4. Update the board
# 5. If a winning condition becomes true
#     a. Go to Step 7 to show the reuslt
#     a. Otherwise, check if there are turns
# 6. If there are turns,
#     a. Repeat Step 2
#     b. Otherwise, go to Step 7
# 7. Update the score (and show the result)
# 8. Ask user to play again
#     a. If yes, go back to Step 1
#     b. Otherwise, end the program

require_relative 'lib/tictactoe'
require_relative 'lib/tictactoe/board'
require_relative 'lib/tictactoe/player'
require_relative 'lib/tictactoe/game'

# Setup game, board, and players
p1 = Player.new('Player 1', 'X')
p2 = Player.new('Player 2', 'O')
b = Board.new

game = Game.new(p1, p2, b)

Tictactoe.start_game(game)

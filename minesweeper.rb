require_relative 'board'
require_relative 'player'
class Game

  def initialize(board, player)
    @board = board
    @player = player
  end

  def play
    until won?
      is_bomb = play_turn
      if is_bomb == :b
        puts "BOOM!"
        break
      end
    end
    if won?
      puts "You won!"
    else
      puts "You lost!"
    end
  end

  def play_turn
    system("clear")
    @board.render
    input = @player.prompt_for_input(@board.grid.size)
    @board.update_cell(input[1], input[0])
  end

  def won?
    # search board tiles for any that are not bombs and not revealed
    @board.grid.each_with_index do |row|
      row.each do |cell|
        return false if cell.value != :b && !cell.revealed
      end
    end
    true
  end
end

board = Board.new
player = Player.new
game = Game.new(board, player)
game.play

require_relative 'board'
require_relative 'player'
require 'yaml'

class Game
  attr_reader :board, :player
  
  def initialize(board, player)
    @board = board
    @player = player
  end

  def save(name)
    File.open("#{name}.yml", 'w') do |f|
      f.puts(self.to_yaml)
    end
  end

  def load(name)
    loaded_state = YAML.load_file("#{name}.yml")
  end

  def play
    puts "Type 'N' to play new game, type 'L' to load game"
    input = gets.chomp.upcase
    if input == 'L'
      puts "Enter name of saved game file"
      saved_game_name = gets.chomp
      saved_game_state = load(saved_game_name)
      @board = saved_game_state.board
      @player = saved_game_state.player
    end
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
    if input[0] == 's'
      puts "Enter name of file"
      file_name = gets.chomp
      save(file_name)
    else
      @board.update_cell(input[1], input[0])
    end
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

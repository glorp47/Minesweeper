require './tile'

class Board
  attr_accessor :grid

  def initialize(size = 9, bombs = 8)
    @grid = Array.new(size) {Array.new(size) {"_"}}
    fill_board(bombs)
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  def fill_board(bombs)
    #made array of values for Tiles, include a given number of bombs
    #then shuffled the array to randomize bomb locations
    # cell_array = Array.new(@grid.size ** 2) {"_"}
    # 0.upto(bombs) do |i|
    #   cell_array[i] = :b
    # end
    # cell_array.shuffle!
    # p cell_array

    bomb_positions = []
    until bomb_positions.length == bombs
      candidate_position = [rand(@grid.size), rand(@grid.size)]
      bomb_positions << candidate_position unless bomb_positions.include?(candidate_position)
    end

    #go through the grid and add a Tile to each spot, which the value
    #from the cell_array
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        current_position = [row_idx, col_idx]
        if bomb_positions.include?(current_position)
          self[current_position] = Tile.new(:b, self, current_position)
        else
          self[current_position] = Tile.new(cell, self, current_position)
        end
      end
    end
  end

  def update_cell(coordinates, decision)
    bomb_count = nil
    if decision == 'f'
      self[coordinates].flag
    else
      bomb_count = self[coordinates].reveal
      # unless bomb_count > 0
      #   update_cell(neighbor_position, decision) unless bomb_count == :b
      # end
    end
    bomb_count
  end

  def render
    puts "   #{(0...@grid.size).to_a.join("  ")}"
      @grid.each_with_index do |row, idx|
        row.each_with_index do |cell, idx2|
          print "#{idx} " if idx2 == 0
          print "|#{cell.to_s}|"
        end
        puts ""
      end
  end
end

class Tile
attr_reader :value, :flagged, :revealed
  def initialize(value, board, pos)
    @value = value
    @board = board
    @pos = pos
    @flagged = false
    @revealed = false
  end

  def bombed?
    if @value == :b && @revealed
      true
    else
      false
    end
  end

  def reveal
    @revealed = true
  end

  def neighbors
    gives us values from all adjacent tiles on the board
  end

  def neighbors_bomb_count
    neighbors.count(:b)
  end


end

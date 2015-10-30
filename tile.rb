require 'byebug'
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

  def flag
    @flagged = !@flagged
  end

  def reveal
    @revealed = true
    if neighbors_bomb_count == 0
      neighbor_positions.each do |neighbor|
        current = @board[neighbor]
        next if current.revealed || current.value == :b
        current.reveal
      end
    end
    @value
  end

  def vectors
    [-1, -1, 0, 1, 1].permutation(2).to_a.uniq
  end

  def neighbor_positions
    result = []
    vectors.each do |delta|
      result << [@pos[0]+ delta[0], @pos[1]+delta[1]]
    end
    result = valid_positions(result)
    result
  end

  def valid_positions(positions)
    positions.select {|move| move[0].between?(0,@board.grid.size - 1) && move[1].between?(0,@board.grid.size - 1)}
  end

  def neighbors
    result = neighbor_positions
    result.map{|position| @board[position].value}
  end

  def neighbors_bomb_count
    neighbors.count(:b)
  end

  def to_s
    return 'F' if @flagged
    @revealed ?  "#{self.neighbors_bomb_count}" : @value
  end

end

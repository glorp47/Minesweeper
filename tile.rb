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
    @flagged ? @flagged = false : @flagged = true
  end

  def reveal
    @revealed = true
    @value
  end

  def neighbors
    # gives us values from all adjacent tiles on the board
    # returns an array of the values
    possible_moves = [-1, -1, 0, 1, 1].permutation(2).to_a.uniq
    result = []
    possible_moves.each do |delta|
      result << [@pos[0]+ delta[0], @pos[1]+delta[1]]
    end
    result.select! {|move| move[0].between?(0,8) && move[1].between?(0,8)}
    result.map{|position| @board.grid[position[0]][position[1]].value}
  end

  def neighbors_bomb_count
    neighbors.count(:b)
  end

  def to_s
    return 'F' if @flagged
    @revealed ?  "#{self.neighbors_bomb_count}" :  @value
  end



  # def inspect
  #   @value
  # end


end

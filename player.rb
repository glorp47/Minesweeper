class Player

  attr_accessor :name

  def initialize(name = "Player")
    @name = name
  end

  def flag_or_reveal
    is_valid = false
    until is_valid
      puts "Enter 'r' to reveal location, enter 'f' to flag location"
      input = gets.chomp.downcase
      is_valid = (input == 'f' || input == 'r')
    end
    input
  end

  def get_coordinates(size)
    is_valid = false
    until is_valid
      puts "Enter coordinates of position you want to modify"
      input = gets.chomp.split(",").map(&:to_i)
      is_valid = (input.all? {|el| el.between?(0, size-1)} )
    end
    input
  end

  def prompt_for_input(size)
    position = get_coordinates(size)
    decision = flag_or_reveal
    [decision, position]
  end
end

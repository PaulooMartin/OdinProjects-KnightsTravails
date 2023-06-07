class GameBoard
  def initialize
    @coordinates = []
    populate_coordinates
  end

  private

  def populate_coordinates
    x = 1
    while x < 9
      y = 1
      while y < 9
        @coordinates << [x, y]
        y += 1
      end
      x += 1
    end
  end
end

class Knight end

class PossibleMove
  attr_reader :current_coordinate
  attr_accessor :next_possible_moves

  def initialize(coordinate)
    @current_coordinate = coordinate
    @next_possible_moves = []
  end
end

board = GameBoard.new

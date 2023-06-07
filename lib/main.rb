class GameBoard
  def initialize
    @coordinates = []
    populate_coordinates
  end

  def knight_moves(start_pos, end_pos)
    knight = Knight.new(start_pos)
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

class Knight
  attr_reader :current_position

  def initialize(start_position)
    from_start = PossibleMove.new(start_position)
    @current_position = from_start.current_coordinate
    @next_moves = from_start.next_possible_moves
  end
end

class PossibleMove
  attr_reader :current_coordinate
  attr_accessor :next_possible_moves

  def initialize(coordinate)
    @current_coordinate = coordinate
    @next_possible_moves = []
  end
end

board = GameBoard.new

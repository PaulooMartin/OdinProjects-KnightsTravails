class GameBoard
  def initialize
    @coordinates = []
    populate_coordinates
  end

  def knight_moves(start_pos, _end_pos)
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

  def initialize(coordinates)
    @current_coordinates = coordinates
    @next_possible_moves = all_possible_coordinates # for now
  end

  def generate_next_possible_moves; end

  private

  def all_possible_coordinates
    x, y = @current_coordinates
    all_possible_coordinates = []
    moving_by_x(x, y).each { |coordinate| all_possible_coordinates.push(coordinate) }
    moving_by_y(x, y).each { |coordinate| all_possible_coordinates.push(coordinate) }
    all_possible_coordinates
  end

  def moving_by_x(coord_x, coord_y)
    possible_coordinates = []
    [-2, 2].each do |shift_x|
      [-1, 1].each do |shift_y|
        possible_coordinates << [coord_x + shift_x, coord_y + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| ((1..8).include? x) && ((1..8).include? y) }
  end

  def moving_by_y(coord_x, coord_y)
    possible_coordinates = []
    [-1, 1].each do |shift_x|
      [-2, 2].each do |shift_y|
        possible_coordinates << [coord_x + shift_x, coord_y + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| ((1..8).include? x) && ((1..8).include? y) }
  end
end

board = GameBoard.new
moves = PossibleMove.new([1, 1])
p moves.next_possible_moves

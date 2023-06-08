class GameBoard
  def initialize
    @tiles = []
    populate_tiles
  end

  def knight_moves(start_pos, _end_pos)
    knight = Knight.new(start_pos)
  end

  private

  def populate_tiles
    x = 1
    while x < 9
      y = 1
      while y < 9
        @tiles << [x, y]
        y += 1
      end
      x += 1
    end
  end
end

class Knight
  def initialize(start_position)
    @current_tile = PossibleMove.new(start_position, 3)
    @next_moves = @current_tile.next_possible_moves
  end

  def current_position
    @current_tile.current_coordinates
  end

  def show_next_moves
    puts "Your next possible moves from current position: #{current_position}"
    @current_tile.next_possible_moves.each { |possible_move| puts "-> #{possible_move.current_coordinates}" }
  end
end

class PossibleMove
  attr_reader :current_coordinates
  attr_accessor :next_possible_moves

  def initialize(coordinates, possibilities_depth)
    @current_coordinates = coordinates
    @next_possible_moves = generate_next_possible_moves(possibilities_depth)
  end

  def generate_next_possible_moves(depth)
    return if depth.negative?

    all_possible_coordinates.map { |coordinates| PossibleMove.new(coordinates, depth - 1) }
  end

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
knight = Knight.new([1, 1])
knight.show_next_moves

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

  def initialize(coordinates, possibilities_depth = 3)
    @current_coordinates = coordinates
    @next_possible_moves = generate_next_possible_moves(possibilities_depth)
  end

  def generate_next_possible_moves(depth)
    return if depth.negative?

    all_possible_coordinates.map { |coordinates| PossibleMove.new(coordinates, depth - 1) }
  end

  def pretty_print(node = self, prefix = '', is_left = true)
    return if node.nil?

    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[0], "#{prefix}#{is_left ? '│   ' : '    '}",
                   false)
    end
    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[1], "#{prefix}#{is_left ? '│   ' : '    '}",
                   false)
    end
    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[2], "#{prefix}#{is_left ? '│   ' : '    '}",
                   false)
    end
    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[3], "#{prefix}#{is_left ? '│   ' : '    '}",
                   false)
    end
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.current_coordinates}"
    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[4], "#{prefix}#{is_left ? '    ' : '│   '}",
                   true)
    end
    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[5], "#{prefix}#{is_left ? '    ' : '│   '}",
                   true)
    end
    unless node.next_possible_moves.nil?
      pretty_print(node.next_possible_moves[6], "#{prefix}#{is_left ? '    ' : '│   '}",
                   true)
    end
    return if node.next_possible_moves.nil?

    pretty_print(node.next_possible_moves[7], "#{prefix}#{is_left ? '    ' : '│   '}",
                 true)
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

  def find_depth_of_future_move(from_path, tile_to_find)
    return 0 if from_path.current_coordinates == tile_to_find
    return 1000 if from_path.next_possible_moves.nil?

    depths_all_next_paths = []
    from_path.next_possible_moves.each do |next_path|
      counter = 1
      counter += find_depth_of_future_move(next_path, tile_to_find)
      depths_all_next_paths << counter
    end
    depths_all_next_paths.min
  end


end

board = GameBoard.new
knight = Knight.new([1, 1])
moves = PossibleMove.new([1, 1], 3)
moves.pretty_print
distance = []
moves.next_possible_moves.each do |path|
  distance << moves.find_depth_of_future_move(path, [1, 3])
end
p distance
p moves.next_possible_moves[0].current_coordinates
p moves.next_possible_moves[1].current_coordinates
# arr.index(arr.min) for future
# make commit for depth

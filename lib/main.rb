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
  attr_reader :current_position, :next_moves

  def initialize(start_position)
    from_start = PossibleMove.new(start_position, 3)
    @current_position = from_start.current_coordinates
    @next_moves = from_start.next_possible_moves
  end
end

class PossibleMove
  attr_reader :current_coordinates
  attr_accessor :next_possible_moves

  def initialize(coordinates, height)
    @current_coordinates = coordinates
    @next_possible_moves = generate_next_possible_moves(height)
  end

  def generate_next_possible_moves(height)
    return if height.zero?

    all_possible_coordinates.map { |coordinates| PossibleMove.new(coordinates, height - 1) }
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
end

board = GameBoard.new
knight = Knight.new([1, 1])

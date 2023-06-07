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
class Move end

board = GameBoard.new

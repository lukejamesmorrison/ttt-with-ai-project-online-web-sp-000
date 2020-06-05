module Players
  class Computer < Player

    def move(board)
      empty_positions = []
      board.cells.each_with_index do |cell, index|
        empty_positions << index + 1 if cell == " "
      end
      empty_positions.sample.to_s
    end

  end
end

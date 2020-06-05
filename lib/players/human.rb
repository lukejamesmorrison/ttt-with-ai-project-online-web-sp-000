module Players
  class Human < Player

    def move(board)
      puts "Player #{@token}, Which cell would you like to play in? (1-9)"
      input = gets.chomp()
    end

  end
end

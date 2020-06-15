class Game

  attr_accessor :player_1, :player_2, :board

  def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def play
    @board.display

    turn until over?
    puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
  end

  def turn
    position = current_player.move(@board)

    if @board.valid_move?(position)
      index = @board.position_as_index(position)
      @board.cells[index] = current_player.token
    else
      puts 'Oops, that position is taken. Try again.'
      turn
    end

    @board.display
    turn
  end

  def current_player
    t_count = @board.turn_count
    t_count == 0 || t_count % 2 == 0 ? @player_1 : @player_2
  end

  def won?
    # The winning combo
    winning_combo = nil

    # Detect if board is empty
    return false if @board.empty?

    # Detect if game has been won
    WIN_COMBINATIONS.each do |combo|
      cell_1 = combo[0]
      cell_2 = combo[1]
      cell_3 = combo[2]

      # If first position is empty, move to next combo immediately
      next if !@board.position_taken?(cell_1)

      # If the cells match
      cells_match = @board.cells[cell_1] == @board.cells[cell_2] && @board.cells[cell_1] == @board.cells[cell_3]

      # If first cell is X or O
      first_is_valid = @board.cells[cell_1] == @player_1.token || @board.cells[cell_1] == @player_2.token

      if first_is_valid && cells_match
        winning_combo = combo
        break
      end
    end

    winning_combo.nil? ? winning_combo : false
  end

  def draw?
    @board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      winning_token = @board.cells[won?[0]]
      player_1.token == winning_token ? player_1.token : player_2.token
    end
  end

  ##
  # The winning combinations of board cells.
  ##
  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5],  # Middle row
    [6, 7, 8],  # Bottom row

    [0, 3, 6],  # Left column
    [1, 4, 7],  # Middle column
    [2, 5, 8],  # Right column

    [0, 4, 8],  # Top-Left cross
    [6, 4, 2]  # Bottom-Left cross
  ]
end

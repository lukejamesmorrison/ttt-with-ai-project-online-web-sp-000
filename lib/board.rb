class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(position)
      index = position_as_index(position)
      @cells[index]
  end

  def position_as_index(position)
    (position.to_i) - 1
  end

  def position_taken?(index)
    !(@cells[index].nil? || @cells[index] == " ")
  end

  def full?
    !@cells.include?(" ")
  end

  def empty?
    empty_cells = @cells.filter {|cell| cell == " "}
    empty_cells.count == @cells.count
  end

  def turn_count
    full_cells = @cells.filter {|cell| cell != " "}
    full_cells.count
  end

  def taken?(position)
    position(position) != " "
  end

  def valid_move?(position)
    !taken?(position) && position.to_i.between?(1,9)
  end

  def update(position, player)
    if valid_move?(position)
      index = position_as_index(position)
      @cells[index] = player.token
    end
  end


end

# frozen_string_literal: true

# Build a function knight_moves that shows the shortest possible way to get from one
# square to another by outputting all squares the knight will stop on along the way

# Each square node contains its position and possible moves
class Square
  attr_accessor :possible_moves

  def initialize(position)
    @position = position
    @possible_moves = next_possible_moves(position)
  end

  def next_possible_moves(position)
    basic_move = [1, -1].product([2, -2]) + [2, -2].product([1, -1])
    possible_moves = []

    basic_move.each do |move|
      row = move[0] + position[0]
      column = move[1] + position[1]
      possible_moves << [row, column] if row.between?(0, 7) && column.between?(0, 7)
    end

    possible_moves
  end
end

# KnightTravils
module Knight
  def self.knight_moves(start, end_pos)
    path = find_shortest_path(start, end_pos)

    puts "You made it in #{path.length - 1} moves!  Here's your path:"
    path.each { |step| p step }
  end

  def self.find_shortest_path(start, end_pos)
    path = [[start]]
    path << add_next_steps(path, end_pos) while path.last != [end_pos]
    path = filter_path(path)

    path.map { |step| step[0] }
  end

  def self.add_next_steps(path, end_pos)
    next_steps = []
    path.last.each do |position|
      possible_moves = Square.new(position).possible_moves
      return [end_pos] if possible_moves.include?(end_pos)

      next_steps += possible_moves
    end
    next_steps.uniq - path.flatten(1)
  end

  def self.filter_path(path)
    result = path.reverse

    2.times do
      result.each_with_index do |moves, index|
        next if moves.length == 1

        result[index] = moves.select do |position|
          next_step = Square.new(result[index - 1][0]).possible_moves

          next_step.include?(position)
        end
      end
      result.reverse!
    end
    result.reverse
  end
end

Knight.knight_moves([0, 0], [7, 7])

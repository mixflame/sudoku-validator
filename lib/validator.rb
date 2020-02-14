require "pry"

class SmallerGrid
  attr_accessor :rows

  def initialize
    @rows = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ]
  end

  def set(top, middle, bottom)
    @rows[0] = top
    @rows[1] = middle
    @rows[2] = bottom
  end

  def valid?
    @rows.flatten == @rows.flatten.uniq
  end
end

class NumberPuzzle
  attr_accessor :grids

  def initialize
    @grids = [
      SmallerGrid.new, SmallerGrid.new, SmallerGrid.new, # TOP
      SmallerGrid.new, SmallerGrid.new, SmallerGrid.new, # MIDDLE
      SmallerGrid.new, SmallerGrid.new, SmallerGrid.new  # BOTTOM
    ]
  end

  # top row of subgrids
  def top
    @grids[0..2]
  end

  def top_left
    @grids[0]
  end

  def top_middle
    @grids[1]
  end

  def top_right
    @grids[2]
  end

  # middle row of subgrids
  def middle
    @grids[3..5]
  end

  def middle_left
    @grids[3]
  end

  def middle_middle
    @grids[4]
  end

  def middle_right
    @grids[5]
  end

  # bottom row of subgrids
  def bottom
    @grids[6..8]
  end

  def bottom_left
    @grids[6]
  end

  def bottom_middle
    @grids[7]
  end

  def bottom_right
    @grids[8]
  end

end

class Validator
  attr_accessor :puzzle_string
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @number_puzzle = NumberPuzzle.new
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    # binding.pry
    parse_puzzle_string

    binding.pry
  end

  def parse_puzzle_string
    # subgroups from top to bottom
    alignments = self.puzzle_string.split("------+------+------\n")

    # all puzzle information
    sets = alignments.map {|x| x.split("\n")}

    top = sets[0]
    middle = sets[1]
    bottom = sets[2]

    # top row of sub grids (top left, top middle, top right)
    top = top.map { |x| x.split("|") }
    top_left = top.map { |x| x.first }
    top_middle = top.map { |x| x[1] }
    top_right = top.map { |x| x.last }
    top_left = top_left.map { |x| x.split(" ") }
    top_middle = top_middle.map { |x| x.split(" ") }
    top_right = top_right.map { |x| x.split(" ") }
    @number_puzzle.top_left.set(top_left[0], top_left[1], top_left[2])
    @number_puzzle.top_middle.set(top_middle[0], top_middle[1], top_middle[2])
    @number_puzzle.top_right.set(top_right[0], top_right[1], top_right[2])

    # middle row of sub grids (middle left, middle middle, middle right)
    middle = middle.map { |x| x.split("|") }
    middle_left = middle.map { |x| x.first }
    middle_middle = middle.map { |x| x[1] }
    middle_right = middle.map { |x| x.last }
    middle_left = middle_left.map { |x| x.split(" ") }
    middle_middle = middle_middle.map { |x| x.split(" ") }
    middle_right = middle_right.map { |x| x.split(" ") }
    @number_puzzle.middle_left.set(middle_left[0], middle_left[1], middle_left[2])
    @number_puzzle.middle_middle.set(middle_middle[0], middle_middle[1], middle_middle[2])
    @number_puzzle.middle_right.set(middle_right[0], middle_right[1], middle_right[2])


    bottom = bottom.map { |x| x.split("|") }
    bottom_left = bottom.map { |x| x.first }
    bottom_middle = bottom.map { |x| x[1] }
    bottom_right = bottom.map { |x| x.last }
    bottom_left = bottom_left.map { |x| x.split(" ") }
    bottom_middle = bottom_middle.map { |x| x.split(" ") }
    bottom_right = bottom_right.map { |x| x.split(" ") }
    @number_puzzle.bottom_left.set(bottom_left[0], bottom_left[1], bottom_left[2])
    @number_puzzle.bottom_middle.set(bottom_middle[0], bottom_middle[1], bottom_middle[2])
    @number_puzzle.bottom_right.set(bottom_right[0], bottom_right[1], bottom_right[2])
  end

end

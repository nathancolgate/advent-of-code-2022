input = File.read(File.expand_path("./input.txt"))
rows = input.split("\n")
row_count = rows.count
col_count = rows.first.chars.length

class Tree
  attr_accessor :height, :x, :y, :visible
  def initialize(height,x,y)
    @height = height.to_i
    @x = x
    @y = y
    @visible = false
  end

  def visible_i
    @visible ? 1 : 0
  end
end

forest = []
rows.each_with_index do |row,row_index|
  row.chars.each_with_index do |height,col_index|
    forest << Tree.new(height,col_index,row_index)
  end
end

# FROM THE WEST
row_count.times do |row|
  tallest_tree = -1
  col_count.times do |col|
    tree = forest.detect {|t| t.y == row && t.x == col}
    if tree.height > tallest_tree
      tree.visible = true
      tallest_tree = tree.height
    end
    break if tallest_tree == 9
  end
end

# FROM THE EAST
row_count.times do |row|
  tallest_tree = -1
  col_count.times do |col|
    tree = forest.detect {|t| t.y == row && t.x == col_count-col-1}
    if tree.height > tallest_tree
      tree.visible = true
      tallest_tree = tree.height
    end
    break if tallest_tree == 9
  end
end

# FROM THE NORTH
col_count.times do |col|
  tallest_tree = -1
  row_count.times do |row|
    tree = forest.detect {|t| t.y == row && t.x == col}
    if tree.height > tallest_tree
      tree.visible = true
      tallest_tree = tree.height
    end
    break if tallest_tree == 9
  end
end

# FROM THE SOUTH
col_count.times do |col|
  tallest_tree = -1
  row_count.times do |row|
    tree = forest.detect {|t| t.y == row_count - row -1 && t.x == col}
    if tree.height > tallest_tree
      tree.visible = true
      tallest_tree = tree.height
    end
    break if tallest_tree == 9
  end
end


# Debug Printing!
row_count.times do |row|
  col_count.times do |col|
    print forest.detect {|t| t.y == row && t.x == col}.height
  end
  print "\n"
end
puts '-'*88
row_count.times do |row|
  col_count.times do |col|
    print forest.detect {|t| t.y == row && t.x == col}.visible_i
  end
  print "\n"
end

puts forest.select {|t| t.visible}.count
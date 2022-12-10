input = File.read(File.expand_path("./sample_input2.txt"))
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

  def score
    @score ||= begin
      n_score * e_score * s_score * w_score
    end
  end

  def n_score
    1
  end

  def e_score
    2
  end

  def s_score
    3
  end

  def w_score
    1
  end
end

forest = []
rows.each_with_index do |row,row_index|
  row.chars.each_with_index do |height,col_index|
    forest << Tree.new(height,col_index,row_index)
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
    print forest.detect {|t| t.y == row && t.x == col}.score
  end
  print "\n"
end

puts forest.map(&:score).max
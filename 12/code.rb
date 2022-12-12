require 'rgl/adjacency'
require 'rgl/dijkstra'

class Elevation
  attr_reader :start, :finish, :altitude, :number
  def initialize(x,y,altitude,map)
    @map = map
    @x = x
    @y = y
    @altitude = ("a".."z").to_a.index(altitude)
    @start = false
    @finish = false
    if altitude == "S"
      @altitude = ("a".."z").to_a.index("a")
      @start = true
    end
    if altitude == "E"
      @altitude = ("a".."z").to_a.index("z")
      @finish = true
    end
    @number = "A#{y*8 + x}-#{@x}-#{y}"
  end

  def n?
    check([@y-1,0].max,@x)
  end

  def e?
    check(@y,@x+1)
  end

  def s?
    check(@y+1,@x)
  end

  def w?
    check(@y,[@x-1,0].max)
  end

  def check(y,x)
    if @map.matrix[y] && @map.matrix[y][x] && @map.matrix[y][x].altitude <= (@altitude + 1)
      @map.matrix[y][x].number
    end
  end
end

class Map
  attr_reader :cycles
  def initialize(file)
    @file = file
    @edge_weights = {}
    parse
  end

  def start
    ObjectSpace.each_object(Elevation).detect {|e| e.start == true }
  end

  def finish
    ObjectSpace.each_object(Elevation).detect {|e| e.finish == true }
  end

  def shortest_path
    puts @edge_weights.inspect
    graph.add_vertices *vertices
    @edge_weights.each { |(city1, city2), w| graph.add_edge(city1, city2) }
    graph.dijkstra_shortest_path(@edge_weights, start.number, finish.number)
  end

  def shortest_path2
    graph.add_vertices *vertices
    @edge_weights.each { |(city1, city2), w| graph.add_edge(city1, city2) }
  end

  def solve2(start_node)
    graph.dijkstra_shortest_path(@edge_weights, start_node.number, finish.number)
  end

  def vertices
    matrix.flat_map {|l| l.map(&:number) }
  end

  def graph
    @graph ||= RGL::DirectedAdjacencyGraph.new
  end

  def input
    File.read(File.expand_path("./#{@file}"))
  end

  def lines
    input.split("\n")
  end

  def matrix
    @matrix ||= begin
      m = []
      lines.each_with_index do |line,y|
        m[y] = []
        line.chars.each_with_index do |char,x|
          m[y][x] = Elevation.new(x,y,char,self)
        end
      end
      m
    end
  end

  def parse
    matrix.each do |line|
      line.each do |elevation|
        @edge_weights[[elevation.number,elevation.n?]] = 1 if elevation.n?
        @edge_weights[[elevation.number,elevation.e?]] = 2 if elevation.e?
        @edge_weights[[elevation.number,elevation.s?]] = 3 if elevation.s?
        @edge_weights[[elevation.number,elevation.w?]] = 4 if elevation.w?
      end
    end
  end
end

map = Map.new('input.txt')
puts '*'*88
map.shortest_path2
solves = []
ObjectSpace.each_object(Elevation).select {|e| e.altitude == 0 }.each do |e|
  begin
    solves << map.solve2(e).length-1
  rescue
    puts "n/a"
  end
end
puts solves.min


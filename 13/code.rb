class PacketPair
  def initialize(first,second)
    puts eval(first).length
    puts eval(second).length
    puts '*'*88
  end
end

class Input
  attr_reader :packets
  def initialize(file)
    @file = file
    @packets = []
  end

  def input
    File.read(File.expand_path("./#{@file}"))
  end

  def data
    input.split("\n\n").map {|d| d.split("\n")}
  end

  def parse
    data.each do |datum|
      @packets << PacketPair.new(datum[0],datum[1])
    end
  end
end

map = Input.new('sample.txt').parse
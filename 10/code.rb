class Cpu
  attr_reader :cycles
  def initialize(file)
    @file = file
    @x = 1
    @cycles = []
    run
  end

  def input
    File.read(File.expand_path("./#{@file}"))
  end

  def commands
    input.split("\n")
  end

  def addx(i)
    2.times do
      @cycles << @x
    end
    @x += i.to_i
    # puts @x
  end

  def noop(i)
    @cycles << @x
  end

  def run
    commands.each do |command|
      match = command.match(/^([a-z]{4})\s?(\-?\d*)$/)
      # puts match.inspect
      send(match[1],match[2])
    end
    @cycles << @x
  end

  def score(important_cycles: [])
    scores = []
    important_cycles.each do |cycle|
      scores << @cycles[cycle-1] * cycle
    end
    scores.sum
  end
end

cpu = Cpu.new('input.txt')
cycles = [20,60,100,140,180,220]
puts cpu.score(important_cycles: cycles)

pixels = cpu.cycles.each_slice(40).to_a
index = 0
pixels.each do |row|
  row.each do |pixel|
    char = (pixel-index).abs < 2 ? '#' : '.'
    print char
    index += 1
  end
  print "\n"
  index = 0
end
    
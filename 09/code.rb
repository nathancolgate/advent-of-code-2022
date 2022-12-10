input = File.read(File.expand_path("./input.txt"))
commands = input.split("\n")

class Knot
  attr_accessor :x, :y, :log, :name
  def initialize(name)
    @name = name
    @x = 0
    @y = 0
    @log = []
    logit
  end
  def logit
    @log << [@x,@y]
  end
  def move(dir)
    case dir
    when 'U'
      @y += 1
    when 'D'
      @y -= 1
    when 'L'
      @x -= 1
    when 'R'
      @x += 1
    when 'UR'
      @y += 1
      @x += 1
    when 'DR'
      @y -= 1
      @x += 1
    when 'UL'
      @y += 1
      @x -= 1
    when 'DL'
      @x -= 1
      @y -= 1
    end
    logit
  end

  def follow(head)
    length = Math.sqrt((head.x - @x)**2 + (head.y - @y)**2)
    dir = case length
    when 0,1,Math.sqrt(2)
      # do nothing
      nil
    when 2
      # Move towards it
      if head.x == @x
        head.y > @y ? 'U' : 'D'
      else
        head.x > @x ? 'R' : 'L'
      end
    when Math.sqrt(5),Math.sqrt(8)
      # Knight's move
      a = head.y > @y ? 'U' : 'D'
      b = head.x > @x ? 'R' : 'L'
      a + b
    end 
    move(dir)  
  end
end

class Rope
  attr_reader :knots
  def initialize(length)
    @knots = []
    length.times do |i|
      @knots << Knot.new(i)
    end
  end
  def move(dir)
    @knots.first.move(dir)
    (1..(@knots.length-1)).to_a.each do |i|
      @knots[i].follow(@knots[i-1])
    end
  end
end

def printer
  6.times do |y|
    6.times do |x|
      i = '.'
      @rope.knots.each do |knot|
        if knot.x == x && knot.y == y
          i = knot.name
        end
      end
      print i
    end
    print "\n"
  end
  print '-'*20+"\n"
end

@rope = Rope.new(10)

commands.each do |command|
  match = command.match(/^([UDLR]) (\d+)$/)
  puts command
  match[2].to_i.times do
    @rope.move(match[1])
    printer
  end
end

puts @rope.knots.last.log.uniq.count

class Rock
  attr_accessor :shape, :altitude
  def initialize(shape,altitude)
    @shape = shape.dup
    @altitude = altitude # of bottom face of rock
  end

  def move_left!
    @shape.map! {|i| i>>1}
  end

  def move_right!
    @shape.map! {|i| i<<1}
  end

  def move_down!
    @altitude -= 1
  end
end

class Shaft
  attr_accessor :deposits, :width
  def initialize
    @width = 7
    @tick = -1
    @rock_count = 1000000000000
    @height = 0
    # 127 is 7 solid bits, or the bottom of the shaft
    @deposits = [127]
    @rock = Rock.new([],0)
    @simulation = Simulation.new(@rock,self)
  end

  def rock_shapes
    @rock_shapes ||= [
      [60],
      [8,28,8],
      [28,16,16],
      [4,4,4,4],
      [12,12]
    ]
  end

  def run
    @rock_count.times do |i|
      puts i if i%1000000 == 0
      add_rock(rock_shapes[i%5])
    end
    puts @height + @deposits.length - 1
  end

  def input
    File.read(File.expand_path("./input.txt"))
  end

  def jets
    @jets ||= input.chars
  end

  def add_rock(shape)
    manage_height
    @deposits += Array.new(3+shape.length,0)
    @rock.shape = shape
    @rock.altitude = @deposits.length-shape.length
    @simulation.rock = @rock
    @tick = @simulation.run(@tick)
    @deposits.reject! {|r| r.zero?}
  end

  def manage_height
    delta = @deposits.length - 64
    if delta > 0
      @height += delta
      @deposits.shift(delta)
    end
  end

end

class Simulation
  attr_accessor :rock,:shaft
  def initialize(rock,shaft)
    @rock = rock
    @shaft = shaft
  end

  def run(tick)
    loop do
      tick += 1
      jet_action(tick)
      break unless fall_action
    end
    return tick
  end

  def fall_action
    if may_move_down?
      @rock.move_down!
      return true
    else
      turn_rock_into_deposit
      return false
    end
  end

  def turn_rock_into_deposit
    @rock.shape.each_with_index.map do |rock_shape,index|
      @shaft.deposits[@rock.altitude+index] = rock_shape|@shaft.deposits[@rock.altitude+index]
    end
  end

  def jet_action(tick)
    jet = @shaft.jets[tick.modulo(@shaft.jets.length)]
    if jet == '<' && may_move_left?
      @rock.move_left!
    elsif jet == '>' && may_move_right?
      @rock.move_right!
    end
  end

  def may_move_left?
    @rock.shape.each_with_index.map do |rock_shape,index|
      # Doesn't hit the left edge of the wall
      rock_shape.nobits?(1) &&
        # Doesn't hit any deposits
        (rock_shape>>1).nobits?(@shaft.deposits[@rock.altitude+index])
    end.all?(true)
  end

  def may_move_right?
    @rock.shape.each_with_index.map do |rock_shape,index|
      # Doesn't hit the wall
      rock_shape.bit_length < @shaft.width &&
        # Doesn't hit any deposits
        (rock_shape<<1).nobits?(@shaft.deposits[@rock.altitude+index])
    end.all?(true)
  end

  def may_move_down?
    @rock.shape.each_with_index.map do |rock_shape,index|
      # Doesn't hit any deposits
      rock_shape.nobits?(@shaft.deposits[@rock.altitude+index-1])
    end.all?(true)
  end
end



s = Shaft.new.run
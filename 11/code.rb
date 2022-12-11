
class Monkey
  attr_accessor :name, :items, :operation, :test, :true_name,:false_name, :gang
  def initialize(name:,items:,operation:,test:,true_name:,false_name:)
    @name = name
    @items = items
    @operation = operation
    @test = test
    @true_name = true_name
    @false_name = false_name
    @gang = nil
    @items_inspected = 0
  end

  def take_turn
    @items.each do |item|
      item.worry_level = operation.call(item.worry_level)
      # lcm = 9699690
      item.worry_level = item.worry_level%9699690
      next_monkey(item).catches(item)
      @items_inspected += 1
    end
    @items = []
  end

  def catches(item)
    @items << item
  end

  def next_monkey(item)
    test.call(item.worry_level) ? true_monkey : false_monkey
  end

  def true_monkey
    @gang.monkeys.detect {|m| m.name == @true_name}
  end

  def false_monkey
    @gang.monkeys.detect {|m| m.name == @false_name}
  end

  def print
    puts "Monkey #{name}: #{items.map(&:worry_level)} (#{@items_inspected})"
  end
end

class Gang
  attr_accessor :monkeys
  def initialize(monkeys)
    @monkeys = monkeys
    @monkeys.each do |monkey|
      monkey.gang = self
    end
  end

  def print
    @monkeys.each do |monkey|
      monkey.print
    end
    puts '*'*44
  end

  def round
    @monkeys.each do |monkey|
      monkey.take_turn
    end
  end
end

class Item
  attr_accessor :worry_level
  def initialize(worry_level)
    @worry_level = worry_level
  end
end

monkeys = [
  Monkey.new({
    name: 0,
    items: [Item.new(66),Item.new(59),Item.new(64),Item.new(51)],
    operation: proc {|x| x*3},
    test: proc {|x| x%2 == 0 },
    true_name: 1,
    false_name: 4
  }),
  Monkey.new({
    name: 1,
    items: [Item.new(67),Item.new(61)],
    operation: proc {|x| x*19},
    test: proc {|x| x%7 == 0 },
    true_name: 3,
    false_name: 5
  }),
  Monkey.new({
    name: 2,
    items: [Item.new(86),Item.new(93),Item.new(80),Item.new(70),Item.new(71),Item.new(81),Item.new(56)],
    operation: proc {|x| x+2},
    test: proc {|x| x%11 == 0 },
    true_name: 4,
    false_name: 0
  }),
  Monkey.new({
    name: 3,
    items: [Item.new(94)],
    operation: proc {|x| x*x},
    test: proc {|x| x%19 == 0 },
    true_name: 7,
    false_name: 6
  }),
  Monkey.new({
    name: 4,
    items: [Item.new(71),Item.new(92),Item.new(64)],
    operation: proc {|x| x+8},
    test: proc {|x| x%3 == 0 },
    true_name: 5,
    false_name: 1
  }),
  Monkey.new({
    name: 5,
    items: [Item.new(58),Item.new(81),Item.new(92),Item.new(75),Item.new(56)],
    operation: proc {|x| x+6},
    test: proc {|x| x%5 == 0 },
    true_name: 3,
    false_name: 6
  }),
  Monkey.new({
    name: 6,
    items: [Item.new(82),Item.new(98),Item.new(77),Item.new(94),Item.new(86),Item.new(81)],
    operation: proc {|x| x+7},
    test: proc {|x| x%17 == 0 },
    true_name: 7,
    false_name: 2
  }),
  Monkey.new({
    name: 7,
    items: [Item.new(54),Item.new(95),Item.new(70),Item.new(93),Item.new(88),Item.new(93),Item.new(63),Item.new(50)],
    operation: proc {|x| x+4},
    test: proc {|x| x%13 == 0 },
    true_name: 2,
    false_name: 0
  })
]

gang = Gang.new(monkeys)
i = 0
10000.times do
  puts i
  gang.round
  i += 1
end
gang.print

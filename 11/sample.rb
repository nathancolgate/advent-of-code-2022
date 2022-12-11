monkeys = [
  Monkey.new({
    name: 0,
    items: [Item.new(79),Item.new(98)],
    operation: proc {|x| x*19},
    test: proc {|x| x%23 == 0 },
    true_name: 2,
    false_name: 3
  }),
  Monkey.new({
    name: 1,
    items: [Item.new(54),Item.new(65),Item.new(75),Item.new(74)],
    operation: proc {|x| x+6},
    test: proc {|x| x%19 == 0 },
    true_name: 2,
    false_name: 0
  }),
  Monkey.new({
    name: 2,
    items: [Item.new(79),Item.new(60),Item.new(97)],
    operation: proc {|x| x*x},
    test: proc {|x| x%13 == 0 },
    true_name: 1,
    false_name: 3
  }),
  Monkey.new({
    name: 3,
    items: [Item.new(74)],
    operation: proc {|x| x+3},
    test: proc {|x| x%17 == 0 },
    true_name: 0,
    false_name: 1
  })
]
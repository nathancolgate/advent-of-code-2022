elves = logs.split("\n\n")
elves.map! do |elf|
  elf.split("\n").map(&:to_i).sum
end
puts elves.sort.reverse[0..2].sum
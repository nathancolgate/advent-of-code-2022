input = File.read(File.expand_path("./input.txt"))
lines = input.split("\n")
priorities = ("a".."z").to_a + ("A".."Z").to_a

scores = []
lines.each do |rucksack|
  rucksack = rucksack.split('')
  compartment_size = rucksack.length / 2
  c1 = rucksack.first(compartment_size)
  c2 = rucksack.last(compartment_size)
  intersection = (c1 & c2).first
  scores << priorities.index(intersection)+1
end
puts scores.sum

scores = []
rucksacks.each_slice(3) do |r1,r2,r3|
  r1 = r1.split('')
  r2 = r2.split('')
  r3 = r3.split('')
  intersection = (r1 & r2 & r3).first
  scores << priorities.index(intersection)+1
end
puts scores.sum

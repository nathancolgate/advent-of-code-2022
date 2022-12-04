input = File.read(File.expand_path("./input.txt"))
assignment_pairs = input.split("\n")

count = 0
assignment_pairs.each do |pair|
  r1,r2 = pair.split(',').map { |p| p.split('-').map(&:to_i)}.map {|a| (a.first..a.last).to_a}
  count += 1 if (r1 & r2) == r1 || (r1 & r2) == r2
end
puts count

count = 0
assignment_pairs.each do |pair|
  r1,r2 = pair.split(',').map { |p| p.split('-').map(&:to_i)}.map {|a| (a.first..a.last).to_a}
  count += 1 if (r1 & r2).any?
end
puts count
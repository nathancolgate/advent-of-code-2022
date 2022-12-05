input = File.read(File.expand_path("./input.txt"))
lines = input.split("\n")

rows = []
lines.each do |line|
  puts line.inspect
  break unless line.include?("[")
  rows << line.chars.each_slice(4).map(&:join).map! {|s| s.match(/[A-Z]/).to_s}
end

columns = []
rows.each do |row|
  row.each_with_index do |box,index|
    columns[index] ||= []
    columns[index] << box unless box == ""
  end
end

# puzzle 1
# lines.each do |line|
#   next unless match = line.match(/^move (\d+) from (\d+) to (\d+)$/)
#   match[1].to_i.times do
#     columns[match[3].to_i-1].unshift(columns[match[2].to_i-1].shift)
#   end
# end

# puzzle 2
lines.each do |line|
  next unless match = line.match(/^move (\d+) from (\d+) to (\d+)$/)
  columns[match[3].to_i-1] = columns[match[2].to_i-1].shift(match[1].to_i) + columns[match[3].to_i-1]
end

puts columns.map(&:first).join()



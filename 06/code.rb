input = File.read(File.expand_path("./input.txt"))
# c = 4
c = 14
i = 0
loop do
  break if input.chars[i..(i+c-1)].uniq.length == c
  i += 1
end
puts i+c
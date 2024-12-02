file_path = 'input.txt'
file_content = File.read(file_path)
lines = file_content.split("\n")
col1 = []
col2 = []
lines.each do |line|
  nums = line.split(' ')
  col1 << nums.first.to_i
  col2 << nums.last.to_i
end

col1 = col1.sort
col2 = col2.sort
differences = []

col1.each_with_index do |num, i|
  differences << (num - col2[i]).abs
end

puts differences.sum

similarity = 0

col1.each do |num|
  similarity += num * col2.count(num)
end

puts similarity

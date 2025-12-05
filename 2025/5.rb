require "set"

input = "3-5
10-14
16-20
12-18

1
5
8
11
17
32"

input = File.read("input.txt")

ranges = input.split("\n\n").first.split("\n")
ranges.map! do |range|
  range.split("-").map(&:to_i)
end

ranges = ranges.sort_by { |x, y| x}

num_fresh = 0
current_start, current_end = 0, 0
ranges.each_with_index do |range|
  x, y = range
  if current_end == 0
    current_start, current_end = x, y
    next
  end

  if x <= current_end
    current_end = [current_end, y].max
  else
    num_fresh += current_end - current_start + 1
    current_start = x
    current_end = y
  end
end

num_fresh += current_end - current_start + 1

puts num_fresh

# ingredients = input.split("\n\n").last.split("\n").map(&:to_i)

# num_fresh = ingredients.count do |ingredient|
#   fresh = false
#   ranges.each do |x, y|
#     fresh = true if ingredient.between?(x, y)
#     break if fresh
#   end
#   fresh
# end

# puts num_fresh

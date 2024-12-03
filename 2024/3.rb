file = 'input.txt'
file_contents = File.read(file)

# file_contents = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

pattern = /mul\(\d+,\d+\)/
do_pattern = /do\(\)/
dont_pattern = /don\'t\(\)/

matches = []
file_contents.scan(pattern) do |match|
  matches << [match, Regexp.last_match.begin(0)]
end

do_indices = []
file_contents.scan(do_pattern) do |match|
  do_indices << Regexp.last_match.begin(0)
end

dont_indices = []
file_contents.scan(dont_pattern) do |match|
  dont_indices << Regexp.last_match.begin(0)
end

# puts matches.to_s
# puts do_indices.to_s
# puts dont_indices.to_s

sum = 0
last_do_index = 0
last_dont_index = 0

matches.each do |match|
  match_index = match.last
  while (do_indices.length > 0 && do_indices.first < match_index) do
    last_do_index = do_indices.first
    do_indices = do_indices[1..-1]
  end

  while (dont_indices.length > 0 && dont_indices.first < match_index) do
    last_dont_index = dont_indices.first
    dont_indices = dont_indices[1..-1]
  end

  if (last_do_index >= last_dont_index)
    nums = match.first[4..-2].split(',').map(&:to_i)
    sum += nums.first * nums.last
  end
end

puts sum

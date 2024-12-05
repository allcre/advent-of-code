file = 'input.txt'
file_contents = File.read(file)

# file_contents = <<~DATA
# 47|53
# 97|13
# 97|61
# 97|47
# 75|29
# 61|13
# 75|53
# 29|13
# 97|29
# 53|29
# 61|53
# 97|53
# 61|29
# 47|13
# 75|47
# 97|75
# 47|61
# 75|61
# 47|29
# 75|13
# 53|13

# 75,47,61,53,29
# 97,61,53,29,13
# 75,29,13
# 75,97,47,61,53
# 61,13,29
# 97,13,75,29,47
# DATA

# break file contents into rules and edits
file_contents = file_contents.split("\n")
break_index = file_contents.index('')
rules = file_contents[0...break_index]
edits = file_contents[break_index+1..-1]

rules = rules.map { |line| line.split('|')}.map { |pair| pair.flat_map { |rule| rule.split(',').map(&:to_i) } }
edits = edits.map { |line| line.split(',').map(&:to_i) }

valid_edits = edits.filter do |edit|
  valid = true
  edit.each_with_index do |num, i|
    other_nums = edit - [num]
    other_nums.each do |other_num|
      if (edit.index(other_num) < i)
        if (rules.include?([num, other_num]))
          valid = false
          break
        end
      else
        if (rules.include?([other_num, num]))
          valid = false
          break
        end
      end
    end
  end
  valid
end

sum = 0
valid_edits.map do |edit|
  sum += edit[(edit.length / 2).floor]
end

# puts rules.to_s
# puts valid_edits.to_s
# puts sum

invalid_edits = edits - valid_edits

# puts invalid_edits.to_s

invalid_edits.map do |edit|
  i = 0
  while (i < edit.length - 1)
    if (rules.include?([edit[i + 1], edit[i]]))
      edit[i], edit[i + 1] = edit[i + 1], edit[i]
      i -= 1 if i != 0
    else
      i += 1
    end
  end
end

sum = 0
invalid_edits.map do |edit|
  sum += edit[(edit.length / 2).floor]
end

puts sum

# puts invalid_edits.to_s
# puts rules.to_s

file = 'input.txt'
file_contents = File.read(file)
num_safe = 0

# file_contents = <<~DATA
# 7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9
# DATA

def is_safe?(nums)
  return false if !((nums.sort == nums) || (nums == nums.sort.reverse))

  nums.each_with_index do |num, index|
    next if index == 0

    difference = (nums[index - 1] - num).abs
    return false if (difference < 1 || difference > 3)

    return true if (index == nums.length - 1)
  end
end

def is_any_permutation_safe?(nums)
  return true if is_safe?(nums)

  nums.each_with_index do |num, index|
    new_nums = nums[0...index] + nums[index + 1..-1]
    puts new_nums.to_s
    if is_safe?(new_nums)
      return true
    end
  end
  return false
end

file_contents.each_line do |line|
  nums = line.split(' ').map(&:to_i)

  if is_any_permutation_safe?(nums)
    num_safe += 1
  end
end


puts num_safe

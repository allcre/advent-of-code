file = 'input.txt'
file_contents = File.read(file)

# file_contents = <<~DATA
# 190: 10 19
# 3267: 81 40 27
# 83: 17 5
# 156: 15 6
# 7290: 6 8 6 15
# 161011: 16 10 13
# 192: 17 8 14
# 21037: 9 7 18 13
# 292: 11 6 16 20
# DATA

equations = file_contents.split("\n").map { |line| line.split(': ') }.map { |pair| pair.map { |rule| rule.split(' ').map(&:to_i) } }
num_valid = 0
sum = 0

operators = ['+', '*', '||']

def make_permutations(operators, length)
  if length <= operators.length
    return operators.permutation(length).to_a
  else
    num_perms = (length.to_f / operators.length.to_f).ceil
    initial_permutations = operators.permutation(operators.length).to_a
    all_permutations = initial_permutations
    (num_perms - 1).times do
      new_perms = operators.permutation(operators.length).to_a
      perm_length = all_permutations.length

      all_permutations.each_with_index do |old_perm, i|
        break if i > perm_length - 1
        new_perms.each do |perm|
          all_permutations << old_perm + perm
        end
      end
      all_permutations = all_permutations[perm_length..-1]
    end
  end
  # puts all_permutations.inspect
  all_permutations
end

def make_perms(operators, length)
  initial = operators.map { |op| [op] }
  perms = []
  perms = initial
  while (perms.length < operators.length ** length)
    new_perms = []
    perms.each do |perm|
      operators.each do |op|
        new_perms << perm + [op]
      end
    end
    perms = new_perms
  end
  perms
end

equations.each do |equation|
  total = equation.first.first
  numbers = equation.last
  perms = make_perms(operators, numbers.length - 1)
  found_valid_perm = false

  perms.each do |perm|
    result = numbers.first
    nums = numbers
    index_offset = 0
    perm.each_with_index do |op, i|
      # i = i - index_offset
      break if i > nums.length - 2
      break if found_valid_perm

      if (op == '+')
        result += nums[i + 1]
      elsif (op == '*')
        result *= nums[i + 1]
      else
        # index_offset += 1

        # if (i == 0)
        #   new_num = (nums[0].to_s + nums[1].to_s).to_i
        #   nums = [new_num] + nums[2..-1]
        #   result = new_num
        # else
        #   # undo last operation
        #   prev_op = perm[i - 1]
        #   if (prev_op == '+')
        #     result -= nums[i]
        #   else
        #     result /= nums[i]
        #   end

        #   # combine numbers
        #   new_num = (nums[i].to_s + nums[i + 1].to_s).to_i
        #   nums = nums[0..(i - 1)] + [new_num] + nums[(i + 2)..-1]

        #   if (prev_op == '+')
        #     result += nums[i]
        #   else
        #     result *= nums[i]
        #   end
        # end

        new_num = (result.to_s + nums[i + 1].to_s).to_i
        # nums[i + 1] = new_num
        result = new_num
      end
    end

    if (result == total)
      num_valid += 1
      sum += total
      found_valid_perm = true

      # puts equation.inspect
      # puts perm.inspect
      # puts result
    end

    # puts equation.inspect
    # puts perm.inspect
    # puts result
  end
end

# puts equations.inspect
puts num_valid
puts sum

input = "987654321111111
811111111111119
234234234234278
818181911112111"

banks = input.split("\n").map{|row| row.split("").map {|x| x.to_i}}

# total_sum = 0
# banks.each do |bank|
#   max_first_digit = bank[...-1].max
#   i = bank.index(max_first_digit)

#   max_second_digit = bank[i+1..].max
#   total_sum += max_first_digit * 10 + max_second_digit
# end

total_sum = 0
num_digits = 12
banks.each do |bank|
  digits = []
  prev_digit_index = -1

  (1..num_digits).each do |digit|
    max_digit = bank[prev_digit_index + 1..-1*(12 - digit + 1)].max
    digits << max_digit
    prev_digit_index = bank[prev_digit_index + 1..].index(max_digit) + prev_digit_index + 1
  end

  num = ""
  digits.each {|x| num += x.to_s}
  num = num.to_i
  total_sum += num
end

puts total_sum

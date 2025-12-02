input = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"

input_array = input.split("\n")
current_number = 50
num_zeros = 0
input_array.each do |instruction|
  direction = instruction[0]
  number = instruction[1...].to_i

  num_full_rotations = number / 100
  remainder = number % 100
  num_zeros += num_full_rotations

  if direction == "L"
    num_zeros += 1 if current_number - remainder <= 0 && current_number != 0
    current_number -= number
  else
    num_zeros += 1 if current_number + remainder >= 100
    current_number += number
  end

  current_number = current_number % 100
end

num_zeros

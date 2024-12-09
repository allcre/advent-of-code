file = 'input.txt'
file_contents = File.read(file)

file_contents = "2333133121414131402\n"

def create_file(file_contents)
  file = []
  is_free_space = false
  index = 0
  file_contents.chars do |char|
    break if char == '\n'
    file << Array.new(char.to_i, is_free_space ? '.' : index.to_s)
    index += 1 if !is_free_space
    is_free_space = !is_free_space
  end
  file.flatten
end

def rearrange_file(file_mem)
  i = 0
  j = file_mem.length - 1
  while i < j
    char = file_mem[j]
    if (char != '.')
      next_free_spot = file_mem[i..j].index('.')
      if !next_free_spot
        return file_mem
      end
      file_mem[j] = '.'
      file_mem[i + next_free_spot] = char
      i += 1
      j -= 1
    else
      j -= 1
    end
  end
  file_mem
end

def rearrange2(file_mem, file_contents)

  file_contents = file_contents.chars.map(&:to_i)[0..-2]
  file_lengths = []
  empty_block_lengths = []
  file_contents.each_with_index do |num, i|
    if (i % 2 == 1)
      empty_block_lengths << num
    else
      file_lengths << num
    end
  end

  i = file_lengths[0] # first empty block
  j = file_mem.length - file_lengths[-1] # start of last file

  while (i <= j)
    if !(empty_block_lengths.max >= file_lengths[-1]) # file cant be moved
      file_lengths.pop
      j -= file_lengths[-1]
      j -= empty_block_lengths.pop
      puts " "
      puts "couldnt move"
      puts "j is at #{j}, which is #{file_mem[j]}"
      puts "empty block lengths: #{empty_block_lengths}"
      puts "file lengths: #{file_lengths}"
      puts "  "
    else
      # file will be moved to left most avail block
      # find first free block that is long enough
      length_free = 0
      start_of_free_block_index = 0
      file_mem[i..j].each_with_index do |char, k|
        if (char == '.')
          if (start_of_free_block_index == 0)
            start_of_free_block_index = k + i
          end
          length_free += 1
        else
          if length_free >= file_lengths[-1]
            break
          end
          length_free = 0
          start_of_free_block_index = 0
        end
      end

      puts "found empty block of length #{length_free} at #{start_of_free_block_index}"

      # moving block
      m = j
      n = start_of_free_block_index
      while (file_mem[m] != '.' && m < file_mem.length)
        file_mem[n] = file_mem[m]
        file_mem[m] = '.'
        m += 1
        n += 1
      end

      puts "moved" + file_mem.inspect

      # update vars
      index = empty_block_lengths.index(length_free)
      empty_block_lengths[index] -= file_lengths[-1]
      puts "... "
      puts "empty block lengths: #{empty_block_lengths}"
      puts "empty_block_lengths.index(#{index}): #{empty_block_lengths[index]}"
      puts "..."
      if (empty_block_lengths[index] == 0)
        empty_block_lengths.delete_at(index)
        file_lengths.delete_at(0)
      end
      i = file_mem.index('.')
      file_lengths.pop
      j -= file_lengths[-1]
      j -= empty_block_lengths.pop

      puts "i is at #{i}, which is #{file_mem[i]}"
      puts "j is at #{j}, which is #{file_mem[j]}"
      puts "empty block lengths: #{empty_block_lengths}"
      puts "file lengths: #{file_lengths}"
    end
  end

  file_mem
end

def checksum(file_contents)
  nums = file_contents.chars.map(&:to_i)
  nums = nums[0..-2]

  # input ends in file not free space
  i = 1 # first free block
  j = nums.length - 1 # last file
  current_start_index = 0
  current_end_index = nums.length - 1
  file_index_end = nums.length / 2
  file_index_start = 0

  sum = 0
  current_start_index += nums[0]
  file_index_start += 1

  while i < j
    if (nums[j] <= nums[i]) # can move block
      puts "i: #{i}, j: #{j}"
      puts "nums[i]: #{nums[i]}, nums[j]: #{nums[j]}"

      nums[j].times do
        sum += file_index_end * current_start_index
        current_start_index += 1
      end
      file_index_end -= 1

      nums[i] -= nums[j]
      j -= 2

      if (nums[i] <= 0)
        nums[i + 1].times do
          sum += file_index_start * current_start_index
          current_start_index += 1
        end
        i += 2
        file_index_start += 1
      end
      current_end_index -= nums[j]
    else
      nums[j].times do
        sum += file_index_end * current_end_index
        current_end_index -= 1
      end
      j -= 2
      file_index_end -= 1
    end
  end
  puts i
  puts j
  sum
end

def sum_mem(file_mem)
  sum = 0
  file_mem.each_with_index do |char, i|
    sum += char.to_i * i if char != '.'
  end
  sum
end


file_mem = create_file(file_contents)
# file_mem = rearrange2(file_mem)
# sum = sum_mem(file_mem)
# puts file_mem.inspect
# puts sum
puts file_mem.inspect
ordered_file = rearrange2(file_mem, file_contents)
puts ordered_file.inspect

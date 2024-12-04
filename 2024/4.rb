file = 'input.txt'
file_contents = File.read(file)

# file_contents = <<~DATA
# MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX
# DATA

def input2array(input)
  input.split("\n").map { |line| line.split('') }
end

grid = input2array(file_contents)

def num_words_starting_at(x_pos, grid)
  x = x_pos.first
  y = x_pos.last
  max_x = grid.first.length
  max_y = grid.length

  num_words = 0

  # check up
  if (y >= 3)
    if (grid[y-1][x] == 'M' && grid[y-2][x] == 'A' && grid[y-3][x] == 'S')
      num_words += 1
    end
  end

  # check down
  if (y <= max_y - 4)
    if (grid[y+1][x] == 'M' && grid[y+2][x] == 'A' && grid[y+3][x] == 'S')
      num_words += 1
    end
  end

  # check left
  if (x >= 3)
    if (grid[y][x-1] == 'M' && grid[y][x-2] == 'A' && grid[y][x-3] == 'S')
      num_words += 1
    end
  end

  # check right
  if (x <= max_x - 4)
    if (grid[y][x+1] == 'M' && grid[y][x+2] == 'A' && grid[y][x+3] == 'S')
      num_words += 1
    end
  end

  # check up-left
  if (y >= 3 && x >= 3)
    if (grid[y-1][x-1] == 'M' && grid[y-2][x-2] == 'A' && grid[y-3][x-3] == 'S')
      num_words += 1
    end
  end

  # check up-right
  if (y >= 3 && x <= max_x - 4)
    if (grid[y-1][x+1] == 'M' && grid[y-2][x+2] == 'A' && grid[y-3][x+3] == 'S')
      num_words += 1
    end
  end

  # check down-left
  if (y <= max_y - 4 && x >= 3)
    if (grid[y+1][x-1] == 'M' && grid[y+2][x-2] == 'A' && grid[y+3][x-3] == 'S')
      num_words += 1
    end
  end

  # check down-right
  if (y <= max_y - 4 && x <= max_x - 4)
    if (grid[y+1][x+1] == 'M' && grid[y+2][x+2] == 'A' && grid[y+3][x+3] == 'S')
      num_words += 1
    end
  end

  num_words
end

total_num_words = 0
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if cell == 'X'
      total_num_words += num_words_starting_at([x, y], grid)
    end
  end
end

def is_x_mas?(a_pos, grid)
  x = a_pos.first
  y = a_pos.last
  max_x = grid.first.length
  max_y = grid.length

  if (x > 0 && x < max_x - 1 && y > 0 && y < max_y - 1)
    c1 = grid[y-1][x-1]
    c2 = grid[y-1][x+1]
    c3 = grid[y+1][x-1]
    c4 = grid[y+1][x+1]
    if ([c1, c2, c3, c4].map { |c| c == 'M' || c == 'S' }.all?)
      return (c1 != c4) && (c2 != c3)
    end
  end
  false
end

total_x_mas = 0
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    if cell == 'A'
      total_x_mas += 1 if is_x_mas?([x, y], grid)
      # if !is_x_mas?([x, y], grid)
      #   puts "#{x}, #{y}"
      # end
    end
  end
end

# puts grid.map { |row| row.join(' ') }
puts total_x_mas

file = 'input.txt'
file_contents = File.read(file)

# file_contents = <<~DATA
# ....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#...
# DATA

FREE = '.'
OBSTACLE = '#'

DIRECTIONS = ["UP", "RIGHT", "DOWN", "LEFT"]

grid = file_contents.split("\n").map { |line| line.split('') }
visited_map = grid.map { |row| row.map { false } }

starting_pos_row = grid.index(grid.find { |row| row.include?('^') })
starting_pos = [starting_pos_row, grid[starting_pos_row].index('^')]

visited_map[starting_pos.first][starting_pos.last] = true

grid[starting_pos.first][starting_pos.last] = FREE

def turn(current_direction)
  DIRECTIONS[(DIRECTIONS.index(current_direction) + 1) % DIRECTIONS.length]
end

def visit(current_pos, visited_map)
  visited_map[current_pos.first][current_pos.last] = true
end

# return true if escaped false if stuck
def escape(current_pos, grid, visited_map)
  num_steps = 0
  current_direction = DIRECTIONS.first

  while (current_pos.first != 0 && current_pos.first != grid.length - 1 && current_pos.last != 0 && current_pos.last != grid.first.length - 1 && num_steps < 15000)
    case current_direction
    when "UP"
      if (grid[current_pos.first - 1][current_pos.last] == FREE)
        current_pos = [current_pos.first - 1, current_pos.last]
      else
        current_direction = turn(current_direction)
      end

    when "RIGHT"
      if (grid[current_pos.first][current_pos.last + 1] == FREE)
        current_pos = [current_pos.first, current_pos.last + 1]
      else
        current_direction = turn(current_direction)
      end

    when "DOWN"
      if (grid[current_pos.first + 1][current_pos.last] == FREE)
        current_pos = [current_pos.first + 1, current_pos.last]
      else
        current_direction = turn(current_direction)
      end

    when "LEFT"
      if (grid[current_pos.first][current_pos.last - 1] == FREE)
        current_pos = [current_pos.first, current_pos.last - 1]
      else
        current_direction = turn(current_direction)
      end
    end

    visit(current_pos, visited_map)
    # visited_map.each do |row|
    #   puts row.map { |cell| cell ? 'X' : '.' }.join(' ')
    # end
    # puts(' ')
    num_steps += 1

  end

  current_pos.first == 0 || current_pos.first == grid.length - 1 || current_pos.last == 0 || current_pos.last == grid.first.length - 1
end

escape(starting_pos, grid, visited_map)

visited = 0
visited_map.each do |row|
  visited += row.count(true)
end

# puts grid.to_s
# puts visited_map.to_s
# puts starting_pos.to_s

# grid.each do |row|
#   puts row.join(' ')

# end

# puts(' ')

# visited_map.each do |row|
#   puts row.map { |cell| cell ? 'X' : '.' }.join(' ')
# end

puts visited

options = 0

visited_map.each_with_index do |row, i|
  row.map.with_index do |cell, j|
    if (cell)
      new_grid = file_contents.split("\n").map { |line| line.split('') }
      new_grid[starting_pos.first][starting_pos.last] = FREE
      new_grid[i][j] = OBSTACLE
      new_visited_map = visited_map

      # new_grid.map do |row|
      #   puts row.join(' ')
      # end
      # puts (' ')

      if !escape(starting_pos, new_grid, new_visited_map)
        options += 1

      end
    end
  end
end

puts options

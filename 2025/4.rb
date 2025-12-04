input = "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@."

grid = input.split("\n").map(&:chars)

removed_something = true
num_removed = 0
while removed_something do
  indices_to_remove = []
  removed_something = false
  grid.each_with_index do |row, i|
    row.each_with_index do |char, j|
      next if char == "."

      num_surrounding = 0

      if i != 0
        num_surrounding += 1 if grid[i-1][j] == "@"

        if j != 0
          num_surrounding += 1 if grid[i-1][j-1] == "@"
        end

        if j != grid.length - 1
          num_surrounding += 1 if grid[i-1][j+1] == "@"
        end
      end

      if j != 0
        num_surrounding += 1 if grid[i][j-1] == "@"

        if i != grid.length - 1
          num_surrounding += 1 if grid[i+1][j-1] == "@"
        end
      end

      if j != grid.length - 1
        num_surrounding += 1 if grid[i][j+1] == "@"

        if i != grid.length - 1
          num_surrounding += 1 if grid[i+1][j+1] == "@"
        end
      end

      if i != grid.length - 1
        num_surrounding += 1 if grid[i+1][j] == "@"
      end

      if num_surrounding < 4
        num_removed += 1
        indices_to_remove << [i, j]
      end
    end
  end

  indices_to_remove.each do |k, l|
    grid[k][l] = "."
    removed_something = true
  end
end

puts num_removed

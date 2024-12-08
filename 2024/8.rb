file = 'input.txt'
file_contents = File.read(file)

file_contents = <<~DATA
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
DATA

require 'set'

grid = file_contents.split("\n").map { |line| line.split('') }

def find_frequencies(grid)
  grid.flatten.select { |char| char != '.' }.to_set
end

found_frequencies = find_frequencies(grid)

def frequency_locations(grid, found_frequencies)
  frequency_locations = {}
  found_frequencies.each do |freq|
    grid.map.with_index do |row, row_index|
      row.map.with_index do |char, col_index|
        if char == freq
          if frequency_locations[freq].nil?
            frequency_locations[freq] = [[row_index, col_index]]
          else
            frequency_locations[freq] << [row_index, col_index]
          end
        end
      end
    end
  end
  frequency_locations
end

def place_antinodes(frequency_locations, grid)
  antinodes = []
  (grid.length).times do
    antinodes << Array.new(grid[0].length, false)
  end

  frequency_locations.each do |freq, locations|
    locations.each_with_index do |location, i|
      row1, col1 = location
      locations[(i + 1)..-1].each do |location2|
        row2, col2 = location2
        antinodes[row1][col1] = true
        antinodes[row2][col2] = true

        row_diff = row2 - row1
        col_diff = col2 - col1
        new_pos = [row1 - row_diff, col1 - col_diff]

        while (new_pos.first >= 0 && new_pos.first < grid.length && new_pos.last >= 0 && new_pos.last < grid[0].length)
          antinodes[new_pos.first][new_pos.last] = true
          new_pos = [new_pos.first - row_diff, new_pos.last - col_diff]
        end

        new_pos = [row2 + row_diff, col2 + col_diff]
        while (new_pos.first >= 0 && new_pos.first < grid.length && new_pos.last >= 0 && new_pos.last < grid[0].length)
          antinodes[new_pos.first][new_pos.last] = true
          new_pos = [new_pos.first + row_diff, new_pos.last + col_diff]
        end
      end
    end
  end

  antinodes
end

def count_antinodes(antinodes)
  count = 0
  antinodes.each do |row|
    count += row.count(true)
  end
  count
end

frequency_locations = frequency_locations(grid, found_frequencies)
# puts frequency_locations.inspect

antinodes = place_antinodes(frequency_locations, grid)

# puts antinodes.inspect
count = count_antinodes(antinodes)
puts count

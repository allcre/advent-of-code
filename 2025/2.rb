input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

id_ranges = input.split(",")
id_pairs = []
id_ranges.each do |range|
  ids = range.split("-").map { |id| id.to_i}
  id_pairs << ids
end

all_ids = []

id_pairs.each do |start_id, end_id|
  (start_id..end_id).each {|id| all_ids << id}
end

invalid_ids = []
all_ids.each do |id|
  id_string = id.to_s
  id_length = id_string.length

  (2..id_length).each do |x|
    is_invalid = id_string[0...id_length/x] * x == id_string
    if is_invalid
      invalid_ids << id
      break
    end
  end
end

invalid_ids.sum

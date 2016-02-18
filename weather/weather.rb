# filename = ARGV.first
#
# day_of_min_spread = nil
# min_spread = nil
#
# File.foreach(filename) do |line|
#   processed_line = line.split()
#   day_number = processed_line[0].to_i
#   if(day_number > 0)
#     max_temp = processed_line[1].to_i
#     min_temp = processed_line[2].to_i
#     spread = max_temp - min_temp
#     if(!min_spread || min_spread > spread)
#       min_spread = spread
#       day_of_min_spread = day_number
#     end
#     puts "Day: #{day_number}\t Max Temp: #{max_temp}\t Min Temp: #{min_temp}\t Spread: #{spread}"
#   end
# end
#
# puts "---------------------------------------------------"
# puts "Day #{day_of_min_spread} had smallest spread with #{min_spread}"
#

module Weather

  def self.calc_spread(num1, num2)
    return (num1-num2).abs
  end

  def self.read_file(filename)
    result = []
    File.foreach(filename) do |line|
      processed_line = line.split()
      if(line_has_valid_data?(processed_line))
        result.push(processed_line)
      end
    end
    result
  end

  def self.line_has_valid_data?(line)
    return line[0].to_i > 0
  end

  def self.get_data_from_file(lines)
    result = {}
    lines.each do |line|
      day_number = line[0]
      max = line[1].to_i
      min = line[2].to_i
      spread = self.calc_spread(min, max)
      result[day_number] = { max: max, min: min, spread: spread }
    end
    result
  end

  def self.find_lowest_spread(data)
    data.min_by{ |key, value| value[:spread] }
  end

end

if __FILE__ == $0
  filename = ARGV.first
  file = Weather.read_file(filename)
  data = Weather.get_data_from_file(file)
  day = Weather.find_lowest_spread(data)
  puts "Day #{day[0]} had lowest spread with value of #{day[1][:spread]}"

end

filename = ARGV.first

day_of_min_spread = nil
min_spread = nil

File.foreach(filename) do |line|
  processed_line = line.split()
  day_number = processed_line[0].to_i
  if(day_number > 0)
    max_temp = processed_line[1].to_i
    min_temp = processed_line[2].to_i
    spread = max_temp - min_temp
    if(!min_spread || min_spread > spread)
      min_spread = spread
      day_of_min_spread = day_number
    end
    puts "Day: #{day_number}\t Max Temp: #{max_temp}\t Min Temp: #{min_temp}\t Spread: #{spread}"
  end
end

puts "---------------------------------------------------"
puts "Day #{day_of_min_spread} had smallest spread with #{min_spread}"


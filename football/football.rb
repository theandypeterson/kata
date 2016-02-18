filename = ARGV.first

File.foreach(filename) do |line|
  processed_line = line.split()
  rank = processed_line[0].to_i
  if(rank > 0)
    team_name = processed_line[1]
    scored_for = processed_line[6].to_i
    scored_against = processed_line[8].to_i
    spread = scored_for - scored_against
    puts "#{team_name}: #{scored_for} - #{scored_against}"

  end
end

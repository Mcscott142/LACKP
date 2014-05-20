# require 'sinatra'
require 'csv'
teams = {}
CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
  # player_info << row.to_hash
  first_name = row["first_name"]
  last_name = row["last_name"]
  position = row["position"]
  team = row["team"]

  if !teams.has_key?(team)
    teams[team] = []
  end

  teams[team] << [first_name, last_name, position]
end

puts teams.inspect

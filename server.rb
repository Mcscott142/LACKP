require 'sinatra'
require 'csv'
require 'pry'
require 'uri'

def read_in_teams
  @teams = {}
  CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
    # player_info << row.to_hash
    first_name = row["first_name"]
    last_name = row["last_name"]
    position = row["position"]
    team = row["team"]

    if !@teams.has_key?(team)
      @teams[team] = []
    end

    @teams[team] << [first_name, last_name, position]
  end
  return @teams
end

# puts read_in_teams.keys

get '/' do
  @data = read_in_teams()
  erb :index
end

get "/teams/:team_name" do
  @team_name = params[:team_name]
  @data = read_in_teams
  #binding.pry
  erb :teampage
end


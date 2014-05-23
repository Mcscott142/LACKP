require 'sinatra'
require 'csv'
require 'pry'
require 'sinatra/reloader'

def import_file(csv)
   players = []
  CSV.foreach(csv, headers: true , header_converters: :symbol) do |player|
    players << player
  end
   players
end

def sort_teams(team)
  players = import_file('lackp_starting_rosters.csv')
  roster = []

  players.each do |player|
    roster << player if player[:team] == team
  end
  roster
end

def sort_positions(position)
  players = import_file('lackp_starting_rosters.csv')
  position_breakdown = []

  players.each do |player|
    position_breakdown << player if player[:position] == position
  end
  position_breakdown
end


get '/teams' do
  @players = import_file('lackp_starting_rosters.csv')
  @team_names =[]
  @players.each do |player|
    if !@team_names.include?(player[:team])
      @team_names << player[:team]
    end

    @positions = []
    @players.each do |player|
      if !@positions.include?(player[:position])
        @positions << player[:position]
      end
    end

  end
  erb :index

end

get '/teams/:team' do
  @team = sort_teams(params[:team])
  #binding.pry
  erb :show
end

get '/positions/:position' do
  @positions = sort_positions(params[:position])
  erb :position_page
end


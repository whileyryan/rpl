# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

def createTeams
  24.times do |team|
    name = Faker::Address.city
    Team.create(name: name)
  end
end

def createPlayers
  @teams = Team.all
  @teams.each do |team|
    5.times do |player|
      name = Faker::Name.name
      retire = rand(3...12)
      mult = rand(0.8...1.25)
      team_id = team.id 
      Player.create(name: name, rookie: 1, retire: retire, mult: mult, team_id: team_id, playing: 1)
    end
  end
end

def firstSeason
  @teams = Team.all
  @teams.each do |team|
    seasonHash = {team_id: team.id, year: 1, wins: 0, losses: 0, pct: 0, points: 0}
    Season.create(seasonHash)
  end
  Game.create(week: 0, year: 1)
end

def loadInitialPoints
  @players = Player.all
  @players.each do |player|
    @season = Season.find_by(team_id: player.team.id).id
    Point.create(season_id: @season, player_id: player.id, points: 0, year: 1)
  end
end



createTeams
firstSeason
createPlayers
loadInitialPoints

class Season < ActiveRecord::Base
  belongs_to :team
  has_many :scores
  require 'faker'

  def self.build
    @seasonCount = Season.count
    if @seasonCount == 0
      @lastSeaseon = 1
    else
      @lastSeaseon = Season.last.year + 1
    end
    @teams = Team.all
    @teams.each do |team|
      seasonHash = {team_id: team.id, year: @lastSeaseon, wins: 0, losses: 0, pct: 0, points: 0}
      Season.create(seasonHash)
    end
    Season.retirePlayers
    Game.create(week: 0, year: @lastSeaseon)
    Season.loadInitialPoints(@lastSeaseon)
  end

  def self.loadInitialPoints(year)
    @players = Player.all
    @players.each do |player|
      @season = Season.find_by(team_id: player.team.id, year: year).id
      Point.create(season_id: @season, player_id: player.id, points: 0, year: year)
    end
  end

  def self.retirePlayers
    @year = Season.last.year
    @players = Player.all
    @players.each do |player|
      if (player.rookie+player.retire) == @year
        new_team_id = player.team_id
        Player.find(player.id).update_attributes(playing: 0)
        Season.recruitNewPlayer(new_team_id, @year)
      end
    end
  end

  def self.recruitNewPlayer(team_id, year)
    name = Faker::Name.name
    retire = rand(3...12)
    mult = rand(0.8...1.25)
    Player.create(name: name, rookie: year, retire: retire, mult: mult, team_id: team_id, playing: 1)
  end
end

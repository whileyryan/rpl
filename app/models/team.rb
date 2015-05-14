class Team < ActiveRecord::Base
  has_many :players
  has_many :seasons
  belongs_to :game
  belongs_to :playoff

  def self.game(week, season)
    week += 1
    teamIdArray = []
    @teams = Team.all 
    @teams.each do |team|
      teamIdArray<<team.id
    end
    teamIdArray.shuffle!
    12.times do |game|
      homeTeam = teamIdArray.pop
      awayTeam = teamIdArray.shift
      gameHash = {week: week, year: season, home_team_id: homeTeam, away_team_id: awayTeam, home_points: 0, away_points: 0}
      Game.create(gameHash)
    end
  end

  def self.results
    @year = Season.last.year
    @games = Game.where(week: Game.last.week, year: @year)
    @games.each do |game|
      homeScore = 0
      awayScore = 0
      game.home_team.players.each do |player|
        if player.playing == 1
          @season = Season.find_by(team_id: player.team.id, year: @year).id
          num = rand(10...50)
          homePlayerPoints = ((num*player.mult).round)
          homeScore += homePlayerPoints
          Team.storePoints(player, @season, homePlayerPoints, @year)
        end
      end
      game.away_team.players.each do |player|
        if player.playing == 1
          @season = Season.find_by(team_id: player.team.id, year: @year).id
          num = rand(10...50)
          awayPlayerPoints = ((num*player.mult).round)
          awayScore += awayPlayerPoints
          Team.storePoints(player, @season, awayPlayerPoints, @year)
        end
      end
      game.update_attributes(:home_points => homeScore)
      game.update_attributes(:away_points => awayScore)
      Season.find_by(team_id: game.home_team.id, year: @year).increment!(:points, by = homeScore)
      Season.find_by(team_id: game.away_team.id, year: @year).increment!(:points, by = awayScore)

      if homeScore > awayScore
        Season.where(team_id: game.home_team.id, year: Season.last.year).last.increment!(:wins)
        Season.where(team_id: game.away_team.id, year: Season.last.year).last.increment!(:losses)
      else
        Season.where(team_id: game.home_team.id, year: Season.last.year).last.increment!(:losses)
        Season.where(team_id: game.away_team.id, year: Season.last.year).last.increment!(:wins)
      end
    end
  end

  def self.storePoints(player, season, points, year)
    Point.find_by(season_id: season, player_id:player.id, year: year).increment!(:points, by = points)
  end

  def self.playoffs
    playoff = []
    @season = Season.last.year
    @teams = Season.where(year: @season).order(wins: :desc, points: :desc).first(8)
    p @teams
    p '-'*100
    @teams.each do |team|
      playoff<<team
    end
    4.times do |add|
      homeTeam = playoff.pop 
      awayTeam = playoff.shift
      Playoff.create(year: @season, week: 1, home_team_id: homeTeam.team_id, away_team_id: awayTeam.team_id, winner_id: nil, loser_id: nil)
    end
  end

  def self.lastRoundsPlayoffs
    winnersBracket = []
    @year = Season.last.year
    @lastGame = Playoff.last.week 
    @winners = Playoff.where(week: @lastGame, year: @year)
    @lastGame += 1
    @winners.each do |winner|
      winnersBracket<<winner.winner 
    end
    (winnersBracket.count/2).times do |add|
      homeTeam = playoff.pop 
      awayTeam = playoff.shift
      Playoff.create(year: @season, week: @lastGame, home_team_id: homeTeam.id, away_team_id: awayTeam.id, winner_id: nil, loser_id: nil)
    end
  end

  def self.resolvePlayoffs
    @year = Season.last.year
    @week = Playoff.last.week
    @initialWeek = @week
    @week += 1
    @playoffs = Playoff.where(week: Playoff.last.week, year: @year)
    i = 1
    @playoffs.each do |game|
      homeScore = 0
      awayScore = 0
      game.home_team.players.each do |player|
        if player.playing == 1
          num = rand(10...50)
          homePlayerPoints = ((num*player.mult).round)
          homeScore += homePlayerPoints
        end
      end
      game.away_team.players.each do |player|
        if player.playing == 1
          num = rand(10...50)
          awayPlayerPoints = ((num*player.mult).round)
          awayScore += awayPlayerPoints
        end
      end
      if homeScore > awayScore
        Playoff.find_by(home_team_id: game.home_team.id, week: @initialWeek, year: @year).update_attributes(winner_id: game.home_team.id, loser_id: game.away_team.id)
        Team.setUpNextRound(i, game.home_team.id, @year, @week)
      else
        Playoff.find_by(home_team_id: game.home_team.id, week: @initialWeek, year: @year).update_attributes(winner_id: game.away_team.id, loser_id: game.home_team.id)
        Team.setUpNextRound(i, game.away_team.id, @year, @week)
      end
      i+=1
    end
  end

  def self.setUpNextRound(i, team_id, year, week)
    if i%2!=0
      Playoff.create(year: year, week: week, home_team_id: team_id)
    else
      Playoff.last.update_attributes(away_team_id: team_id)
    end
  end

  def self.determineWinner
    @championship = Playoff.last 
    @year = Season.last.year
    homeScore = 0
    awayScore = 0
    @championship.home_team.players.each do |player|
      if player.playing == 1
        num = rand(10...50)
        homePlayerPoints = ((num*player.mult).round)
        homeScore += homePlayerPoints
      end
    end
    @championship.away_team.players.each do |player|
      if player.playing == 1
        num = rand(10...50)
        awayPlayerPoints = ((num*player.mult).round)
        awayScore += awayPlayerPoints
      end
    end
    if homeScore > awayScore
      Winner.create(team_id: @championship.home_team.id, season_id: @year)
    else
      Winner.create(team_id: @championship.away_team.id, season_id: @year)
    end
  end
end

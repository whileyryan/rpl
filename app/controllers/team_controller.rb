class TeamController < ApplicationController
  def index
    @seasons = Season.where(year: Season.last.year).order(wins: :desc, points: :desc)
  end


  def game
    @season = Season.where(year: Season.last.year).last.year
    @week = Game.where(year: @season).last.week
    @playoff = Playoff.where(year: @season).count
    if @week < 30
      Team.game(@week, @season)
    elsif @week == 30 && @playoff == 0
      Team.playoffs
      redirect_to '/playoffs'
    else
      if Playoff.last.week < 3
        redirect_to '/playoffs'
      elsif Playoff.last.week == 3
        Team.determineWinner
        redirect_to '/winner'
      end
    end
    @games = Game.where(week: Game.last.week, year: Season.last.year)
  end

  def winner
    @winner = Winner.last 
  end

  def playoffs
    @year = Season.last.year
    @playoffs = Playoff.where(week: Playoff.last.week, year: @year)
  end

  def results
    Team.results
    @games = Game.where(week: Game.last.week, year: Season.last.year)
  end

  def topScorers
    @season = Season.last.year
    @teams = Season.where(year: @season).order(points: :desc)
    @week = Game.last.week
    if @week == 0
      @week = 1
    end
    @points = Point.where(year: @season).order(points: :desc).first(10)
  end

  def playoffResults
    @week = Playoff.last.week
    @season = Season.last.year
    Team.resolvePlayoffs
    @playoffs = Playoff.where(week: @week, year: @season)
  end

  def allTime
    @points = Point.all.order(points: :desc).first(20)
    @teamsPoints = Season.all.order(points: :desc).first(20)
    @teamsWins = Season.all.order(wins: :desc).first(20)
  end

  def champions
    @winners = Winner.all
  end
end




class Playoff < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  belongs_to :winner, :class_name => 'Team'
  belongs_to :loser, :class_name => 'Team'
  has_many :teams
end

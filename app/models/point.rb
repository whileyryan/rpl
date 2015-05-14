class Point < ActiveRecord::Base
  belongs_to :season
  belongs_to :player
end

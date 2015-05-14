class SeasonController < ApplicationController
  def build
    Season.build
    redirect_to '/'
  end
end

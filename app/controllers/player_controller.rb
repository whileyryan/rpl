class PlayerController < ApplicationController
	def show
		@seasons = Point.where(player_id: params[:id], points: 0).order(:year)
		@player = Player.find(params[:id])
		@team = Team.find(@player.team_id)
	end
end

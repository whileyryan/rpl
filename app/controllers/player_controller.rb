class PlayerController < ApplicationController
	def show
		@seasons = Point.where(player_id: params[:id], points: 0..Float::INFINITY).order(:year)
		@player = Player.find(params[:id])
		@team = Team.find(@player.team_id)
	end
end

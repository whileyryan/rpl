class PlayerController < ApplicationController
	def show
		@seasons = Point.where(player_id: params[:id], points: 1..Float::INFINITY).order(:year)
		@player = Player.find(params[:id])
		@team = Team.find(@player.team_id)
	end

	def dismiss
		Player.find(params[:id]).update_attributes(:retire => Season.last.year)
		redirect_to "/players/#{params[:id]}"
	end
end

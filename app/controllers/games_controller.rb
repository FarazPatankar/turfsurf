class GamesController < ApplicationController
	def index
		@games = Game.where("start_time > ?", DateTime.now + 1.hour)
		session[:invited_user] = false
	end
	def create
		@arena = Arena.find_by(id: params[:arena_id])
		@game = @arena.games.new(game_params)

		@game.user = current_user
		if @game.save
			@game.tweet(@game.user.username, @game.arena.name, @game.id)
			redirect_to arena_game_path(@arena, @game)
		else
			redirect_to arena_path(@arena)
		end
	end

	def show
		if params[:arena_id] && params[:id]
			@arena = Arena.find_by(id: params[:arena_id])
			@game = @arena.games.find_by(id: params[:id])
			@invite = @game.invites.new
		else
			@game = Game.find_by(id: params[:id])
			@invites = @game.invites
			@accepted = []
			@yet = []
			@rejected =[]
			@is_current_accepted = false

			@invites.each do |invite|
				if invite.response == 1
					if user_signed_in?
						if invite.email == current_user.email
							@is_current_accepted = true
						end
					end

					@accepted.push(invite)
				elsif invite.response == 0
					@yet.push(invite)
				elsif invite.response == 2
					@rejected.push(invite)
				end
			end

			render :play
		end
	end

	private
	def game_params
		params[:game][:start_time] = params[:date] + "T" + params[:game][:start_time]
		params[:game][:end_time] = params[:date] + "T" + params[:game][:end_time]
		params.require(:game).permit(:start_time, :end_time)
	end
end

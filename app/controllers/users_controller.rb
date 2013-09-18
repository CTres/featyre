class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@features = @user.owned_features
	end
end

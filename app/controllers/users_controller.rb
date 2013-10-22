class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@features = @user.owned_features
	end

	def update
	end

	def update_feature_user
		@feature_user = FeatureUser.find_by_user_id_and_feature_id(params[:user_id],params[:id])
		respond_to do |format|
			if @feature_user.update_attribute(:role, params[:user][:role])
		        format.html { redirect_to :back, notice: @feature_user.user.name + " has been updated" }
		        format.js {}
      		else
        		render action: "edit" 
      		end
  		end	
	end
end

module FeaturesHelper
  def user_owner
  	@feature.collaborator_list.include?(current_user)
	end
end

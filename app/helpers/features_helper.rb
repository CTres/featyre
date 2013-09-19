module FeaturesHelper
	  def user_owner
    @feature.collaborators_list.include?(current_user)
  end
end

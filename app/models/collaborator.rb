class Collaborator < ActiveRecord::Base
	belongs_to :user 
	belongs_to :feature
	attr_accessible :user_id, :feature_id
end

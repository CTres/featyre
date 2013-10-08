class FeatureUser< ActiveRecord::Base
	#Associations
	belongs_to :feature, :dependent => :destroy
	belongs_to :user 
	#Attributes
	attr_accessible :user_id, :feature_id, :role
end

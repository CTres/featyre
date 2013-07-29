class FeatureUser< ActiveRecord::Base
	belongs_to :feature, :dependent => :destroy
	belongs_to :user 
	attr_accessible :user_id, :feature_id


end

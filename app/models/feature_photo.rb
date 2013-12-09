class FeaturePhoto< ActiveRecord::Base
	#Associations
	belongs_to :feature, :dependent => :destroy
	belongs_to :photo
	#Attributes
	attr_accessible :photo_id, :feature_id
	accepts_nested_attributes_for :photo
end

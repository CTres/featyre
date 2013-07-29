class Feature < ActiveRecord::Base
	#Associatations
  belongs_to :user
  has_many :feature_users, foreign_key: "feature_id"
  has_many :collaborators, class_name: 'User', through: :feature_users, source: :user
 	accepts_nested_attributes_for :feature_users

 	#Accessible
  attr_accessible :text, :title, :tag_list, :url, :description, :collaborator_ids
  acts_as_taggable_on :tags
end
	
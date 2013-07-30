class Feature < ActiveRecord::Base
	#Associations
  belongs_to :user
  has_many :feature_users
  has_many :collaborators, class_name: 'User', through: :feature_users, source: :user, select: :username
 	
 	#Attributes
 	accepts_nested_attributes_for :feature_users
 	attr_accessible :user_id, :text, :title, :tag_list, :url, :description, :collaborator_ids, :collaborators_list, :collaborators, :collaborator_list

 	#Scopes
  acts_as_taggable_on :tags

  #Methods
  def collaborator_list()
  	collaborators = self.collaborators
  	collaborators.each do |collaborator|
  		collaborator_list = collaborator
  	end
  end
end
	
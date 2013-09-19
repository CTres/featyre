class Feature < ActiveRecord::Base
	#Associations
  belongs_to :user
  has_many :feature_users
  has_many :collaborators, class_name: 'User', through: :feature_users, source: :user
 	
 	#Attributes
 	accepts_nested_attributes_for :feature_users
 	attr_accessible :user_id, :text, :title, :tag_list, :url, :description,  
  :collaborator_ids, :collaborators, :collaborator_list, :company
  attr_accessor :temp_collaborator

 	#Scopes
  acts_as_taggable_on :tags

  #Methods

  #An array of user objects that are collaborators
  def collaborators_list()
  	collaborators = self.collaborators.to_a
  end

  def collaborators_names()
    self.collaborators.each do |collaborator|
      puts collaborator.username
    end
  end
  def insert_collaborator(username, token)
    #check to see if the collaborator is already added
    unless self.collaborators.include?(User.find_by_username(username))
      unless User.find_by_username(username).nil?
        self.collaborators << User.find_by_username(username)
      else
      g = Github.new(token)
      github_user = g.find_by_username(username)
      self.collaborators << g.create_user_by_username(github_user)
      end
    end
  end

  def delete_collaborator(username)
   user = User.find_by_username(username)
   self.collaborators.delete(user)
  end
end
	

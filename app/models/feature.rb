class Feature < ActiveRecord::Base
	#Associations
  belongs_to :user
  has_many :feature_users
  has_many :collaborators, class_name: 'User', through: :feature_users, source: :user, select: :username
 	
 	#Attributes
 	accepts_nested_attributes_for :feature_users
 	attr_accessible :user_id, :text, :title, :tag_list, :url, :description, :collaborator_ids, :collaborators_list, :collaborators, :collaborator_list
  attr_accessor :temp_collaborator

 	#Scopes
  acts_as_taggable_on :tags

  #Methods
  def collaborators_list()
  	collaborators = self.collaborators
  end

  def collaborators_names()
    self.collaborators.each do |collaborator|
      puts collaborator.username
    end
  end
  def insert_collaborator(username, token)
    unless User.find_by_username(username).nil? || (self.collaborators.include? User.find_by_username(username))
      self.collaborators << User.find_by_username(username)
    else 
      puts 'creating github token'
      g = Github.new(token)
      github_user = g.find_by_username(username)
      self.collaborators << g.create_user_by_username(github_user)

    end
  end

  def delete_collaborator(username)
   user = User.find_by_username(username)
   self.collaborators.delete(user)
  end
end
	

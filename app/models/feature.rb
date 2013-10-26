class Feature < ActiveRecord::Base
  after_initialize :init

	#Associations
  belongs_to :user
  has_many :feature_users
  has_many :values
  has_many :images
  has_many :collaborators, class_name: 'User', through: :feature_users, source: :user, select: 'users.*, feature_users.role as role'
 	#Attributes
 	accepts_nested_attributes_for :feature_users, :values
 	attr_accessible :feature_users_attributes, :values_attributes,  :user_id, :text, :title, :tag_list, :url, :description, :collaborators, :collaborator_list, :company, :subtitle
  attr_accessor :temp_collaborator, :temp_role

  #Validations
  #validates :title, :tag_list, :subtitle, presence: true
  
 	#Scopes
  acts_as_taggable_on :tags

  #Methods
  #An array of user objects that are collaborators
  def collaborator_list()
  	collaborators = self.collaborators.to_a
  end

  def find_or_create_collaborator(string, token)
    #check if input is an email
    if string.match(/\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/)
      #check to see if user is in database with email
      if User.find_by_email(string).nil?
        #!!!!!add check to see if github has a user with that email before creating new user
        #if no user in db with email, create user
        user = User.from_email(string)
        return user.id
      else
        user = User.find_by_email(string)
        return user.id
      end
    else
    #check to see if the collaborator is already added
      unless self.collaborators.include?(User.find_by_username(string))
        unless User.find_by_username(string).nil?
          user = User.find_by_username(string)
          return user.id

        else
        g = Github.new(token)
        github_user = g.find_by_username(string)
        user = g.create_user_by_username(github_user)
        return user.id
        end
      end
    end
  end

  def delete_collaborator(username)
   user = User.find_by_username(username)
   self.collaborators.delete(user)
  end

  def init
    self.company ||= self.user.company
  end
end
	

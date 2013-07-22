class Feature < ActiveRecord::Base
  belongs_to :user
  has_many :users, :through => :collaborators

  attr_accessible :text, :title, :tag_list, :url, :description, :collaborators, :user_id
  acts_as_taggable_on :tags
end

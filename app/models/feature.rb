class Feature < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  accepts_nested_attributes_for :collaborators

  attr_accessible :text, :title, :tag_list, :url, :description, :collaborators, :user_id
  acts_as_taggable_on :tags
end

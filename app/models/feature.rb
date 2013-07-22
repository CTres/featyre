class Feature < ActiveRecord::Base
  belongs_to :user
  attr_accessible :text, :title, :tag_list, :user_id, :url, :description
  acts_as_taggable_on :tags
end

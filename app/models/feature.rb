class Feature < ActiveRecord::Base
  belongs_to :user
  attr_accessible :text, :title
end

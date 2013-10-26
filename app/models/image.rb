class Image < ActiveRecord::Base
  belongs_to :feature
  # attr_accessible :title, :body
  attr_accessible :image, :feature_id

    #Image Uploader
  mount_uploader :image, ImageUploader
  
end

class Photo < ActiveRecord::Base
  belongs_to :feature
  # attr_accessible :title, :body
    #Image Uploader
  attr_accessible :image, :feature_id, :remove_image, :name
  mount_uploader :image, ImageUploader

  def find_or_create(id)
  	unless Photo.find(id).nil?

  	end	
	end
  		
end

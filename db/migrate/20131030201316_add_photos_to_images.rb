class AddPhotosToImages < ActiveRecord::Migration
  def change
  	add_column :images, :photo, :string
  	remove_column :images, :image, :string
  end
end

class Changetablename < ActiveRecord::Migration
  def up
  	rename_table :images, :photos
  	rename_column :photos, :photo, :image
  end

  def down
  end
end

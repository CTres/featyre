class AddImageToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :image, :string
  end
end

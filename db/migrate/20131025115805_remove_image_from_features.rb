class RemoveImageFromFeatures < ActiveRecord::Migration
  def change
    remove_column :features, :image, :string
  end
end

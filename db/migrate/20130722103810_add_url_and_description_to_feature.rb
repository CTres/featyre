class AddUrlAndDescriptionToFeature < ActiveRecord::Migration
  def change
    add_column :features, :url, :string
    add_column :features, :description, :string
  end
end

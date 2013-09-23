class AddSubtitleToFeatures < ActiveRecord::Migration
  def change
  	add_column :features, :subtitle, :string
  end
end

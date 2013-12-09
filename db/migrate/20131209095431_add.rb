class Add < ActiveRecord::Migration
  def change
  	add_column :photos, :primary, :boolean, default: false
  end
end

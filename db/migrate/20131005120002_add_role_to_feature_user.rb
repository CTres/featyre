class AddRoleToFeatureUser < ActiveRecord::Migration
  def change
  	add_column :feature_users, :role, :string
  end
end

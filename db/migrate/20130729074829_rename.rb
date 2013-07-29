class Rename < ActiveRecord::Migration
def change
	rename_table :features_user, :feature_users
end
end

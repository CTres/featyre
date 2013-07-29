class RenameCollaboratorsToFeatureUsers < ActiveRecord::Migration
	def change
		rename_table :collaborators, :features_user
	end

end

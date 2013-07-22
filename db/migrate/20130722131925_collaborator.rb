class Collaborator < ActiveRecord::Migration
  def up
  	create_table :collaborators do |t|
      t.references :user
      t.references :feature
      t.datetime :created_at
    end
	end
end

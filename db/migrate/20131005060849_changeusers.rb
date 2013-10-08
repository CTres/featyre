class Changeusers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :url, :string
    add_column :users, :location, :string
    add_column :users, :blog, :string
    add_column :users, :avatar_url, :string
    add_column :users, :hireable, :string
    add_column :users, :gravatar_id, :string
  end
end
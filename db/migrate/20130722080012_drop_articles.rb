class DropArticles < ActiveRecord::Migration
  def up
  	drop_table :articles
  end

  def down
  end
end

class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :text
      t.references :user

      t.timestamps
    end
    add_index :features, :user_id
  end
end

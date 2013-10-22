class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :persona
      t.string :metric
      t.string :change
      t.string :quantity
      t.references :feature
      t.timestamps
    end
  end
end

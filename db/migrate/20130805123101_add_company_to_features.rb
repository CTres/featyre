class AddCompanyToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :company, :string
  end
end

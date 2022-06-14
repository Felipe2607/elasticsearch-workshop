class AddLocationToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :latitude, :string, null: false
    add_column :products, :longitude, :string, null: false
  end
end

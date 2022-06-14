class AddLocationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :latitude, :string, null: false
    add_column :users, :longitude, :string, null: false
  end
end

class AddFlagToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :flag, :string
  end
end

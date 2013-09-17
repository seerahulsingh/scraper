class AddFieldsToRestaurant < ActiveRecord::Migration
  def change
  	add_column :restaurants, :lat, :decimal, :precision => 16, :scale => 13
    add_column :restaurants, :lng, :decimal, :precision => 16, :scale => 13
    add_column :restaurants, :district, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :postcode, :string
    add_column :restaurants, :country, :string
    add_column :restaurants, :direction, :text
    add_column :restaurants, :service_avg, :float, default: 0
    add_column :restaurants, :quality_avg, :float, default: 0
    add_column :restaurants, :value_avg, :float, default: 0
    add_column :restaurants, :rating_avg, :float, default: 0
    add_column :restaurants, :price, :decimal, :default => 0
    add_column :restaurants, :menu_uid,  :string
    add_column :restaurants, :menu_name, :string
    change_column :restaurants, :disabled, :boolean, :default => nil
    add_column :restaurants, :is_owner, :boolean
    add_column :restaurants, :contact_note, :string
    add_column :restaurants, :suggester_name, :string
    add_column :restaurants, :website, :string
    add_column :restaurants, :halal_status, :text
    add_column :restaurants, :short_address, :string
  end
end

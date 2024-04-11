class AddAreaAndLandmarkToOrderAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :order_addresses, :landmark, :string
    add_column :order_addresses, :area, :string, null: false
    change_column :order_addresses, :city, :string, null: false
    change_column :order_addresses, :state, :string, null: false
  end
end

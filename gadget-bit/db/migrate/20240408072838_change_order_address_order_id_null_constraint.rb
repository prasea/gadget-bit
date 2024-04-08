class ChangeOrderAddressOrderIdNullConstraint < ActiveRecord::Migration[7.1]
  def change
    change_column :order_addresses, :order_id, :bigint, null: true
  end
end

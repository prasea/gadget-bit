class RemoveNullConstrainsFromOrderAddress < ActiveRecord::Migration[7.1]
  def change
    change_column_null :order_addresses, :city, true
    change_column_null :order_addresses, :state, true
    change_column_null :order_addresses, :area, true
  end
end

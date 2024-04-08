class CreateOrderAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :order_addresses do |t|
      t.string :city
      t.string :state
      t.belongs_to :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
